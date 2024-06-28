/* SPDX-License-Identifier: GPL-2.0 */

#include <osl.h>
#include <dhd_linux.h>
#include <linux/gpio.h>
#include <linux/rfkill-wlan.h>

#ifdef CONFIG_BROADCOM_WIFI_RESERVED_MEM
extern int dhd_init_wlan_mem(void);
extern void dhd_exit_wlan_mem(void);
extern void *dhd_wlan_mem_prealloc(int section, unsigned long size);
#endif /* CONFIG_BROADCOM_WIFI_RESERVED_MEM */

static int dhd_wlan_set_power(int on);
static int dhd_wlan_set_reset(int onoff);
static int dhd_wlan_set_carddetect(int present);
static int dhd_wlan_get_mac_addr(unsigned char *buf);
static void *dhd_wlan_get_country_code(char *ccode
#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 58)) || defined(CUSTOM_COUNTRY_CODE)
		, u32 flags
#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 58)) */
);

struct wifi_platform_data dhd_wlan_control = {
	.set_power	= dhd_wlan_set_power,
	.set_reset	= dhd_wlan_set_reset,
	.set_carddetect	= dhd_wlan_set_carddetect,
	.get_mac_addr	= dhd_wlan_get_mac_addr,
	.get_country_code = dhd_wlan_get_country_code,
#ifdef CONFIG_BROADCOM_WIFI_RESERVED_MEM
	.mem_prealloc	= dhd_wlan_mem_prealloc,
#endif /* CONFIG_BROADCOM_WIFI_RESERVED_MEM */
};

struct resource dhd_wlan_resources = {
	.name	= "bcmdhd_wlan_irq",
	.start	= 0,
	.end	= 0,
	.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE |
#ifdef BCMPCIE
	IORESOURCE_IRQ_HIGHEDGE,
#else
	IORESOURCE_IRQ_HIGHLEVEL,
#endif /* BCMPCIE */
};

static struct cntry_locales_custom brcm_wlan_translate_custom_table[] = {
	/* Table should be filled out based on custom platform regulatory requirement */
	{"",   "XT", 49},  /* Universal if Country code is unknown or empty */
	{"US", "US", 0},
};

#ifdef CUSTOM_FORCE_NODFS_FLAG
struct cntry_locales_custom brcm_wlan_translate_nodfs_table[] = {
	{"",   "XT", 50},  /* Universal if Country code is unknown or empty */
	{"US", "US", 0},
};
#endif /* CUSTOM_FORCE_NODFS_FLAG */

static int dhd_wlan_set_power(int on)
{
	int ret;
	ret = rockchip_wifi_power(on);
	if (ret)
		printk(KERN_ERR "%s: failed to set power=%d,"
				" ret=%d\n", __FUNCTION__, on, ret);
	return 0;
}

static int dhd_wlan_set_reset(int onoff)
{
	return 0;
}

static int dhd_wlan_set_carddetect(int present)
{
	int ret;
#ifdef BCMSDIO
	ret = rockchip_wifi_set_carddetect(present);
	if (ret)
		printk(KERN_ERR "%s: failed to set carddetect=%d,"
				" ret=%d\n", __FUNCTION__, present, ret);
#endif /* BCMSDIO */
	return 0;
}

static int dhd_wlan_get_mac_addr(unsigned char *buf)
{
	return rockchip_wifi_mac_addr(buf);
}

static void *dhd_wlan_get_country_code(char *ccode,
#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 58)) || defined(CUSTOM_COUNTRY_CODE)
	u32 flags
#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 58)) */
)
{
	struct cntry_locales_custom *locales;
	int size;
	int i;

	if (!ccode)
		return NULL;

#ifdef CUSTOM_FORCE_NODFS_FLAG
	if (flags & WLAN_PLAT_NODFS_FLAG) {
		locales = brcm_wlan_translate_nodfs_table;
		size = ARRAY_SIZE(brcm_wlan_translate_nodfs_table);
	} else {
#endif
		locales = brcm_wlan_translate_custom_table;
		size = ARRAY_SIZE(brcm_wlan_translate_custom_table);
#ifdef CUSTOM_FORCE_NODFS_FLAG
	}
#endif

	for (i = 0; i < size; i++)
		if (strcmp(ccode, locales[i].iso_abbrev) == 0)
			return &locales[i];
	return NULL;
}


int dhd_wlan_init(void)
{
#ifdef CONFIG_BROADCOM_WIFI_RESERVED_MEM
	int ret;
#endif /* CONFIG_BROADCOM_WIFI_RESERVED_MEM */
#ifdef CONFIG_BCMDHD_OOB_HOST_WAKE
	uint irq;
	int irq_flags = -1;
#endif /* CONFIG_BCMDHD_OOB_HOST_WAKE */

	printf("%s, enter\n", __FUNCTION__);

#ifdef CONFIG_BROADCOM_WIFI_RESERVED_MEM
	ret = dhd_init_wlan_mem();
	if (ret < 0) {
		printk(KERN_ERR "%s: failed to alloc reserved memory,"
				" ret=%d\n", __FUNCTION__, ret);
		return ret;
	}
#endif /* CONFIG_BROADCOM_WIFI_RESERVED_MEM */
#ifdef CONFIG_BCMDHD_OOB_HOST_WAKE
	irq = rockchip_wifi_get_oob_irq();

	printf("%s, irq = %d", __FUNCTION__, irq);

	dhd_wlan_resources.start = irq;
	dhd_wlan_resources.end = irq;

	irq_flags = rockchip_wifi_get_oob_irq_flag();
#ifdef BCMPCIE
	if (irq_flags == 1) {
		dhd_wlan_resources.flags |= IORESOURCE_IRQ_HIGHEDGE;
	} else if (irq_flags == 0) {
		dhd_wlan_resources.flags |= IORESOURCE_IRQ_LOWEDGE;
	} else {
		pr_warn("%s: unknown oob irqflags !\n", __func__);
	}
#else /* BCMPCIE */
	if (irq_flags == 1) {
		dhd_wlan_resources.flags |= IORESOURCE_IRQ_HIGHLEVEL;
	} else if (irq_flags == 0) {
		dhd_wlan_resources.flags |= IORESOURCE_IRQ_LOWLEVEL;
	} else {
		pr_warn("%s: unknown oob irqflags !\n", __func__);
	}
#endif /* BCMPCIE */
#endif /* CONFIG_BCMDHD_OOB_HOST_WAKE */

	return 0;
}

int dhd_wlan_deinit(void)
{
	printf("%s, enter\n", __FUNCTION__);

#ifdef CONFIG_BROADCOM_WIFI_RESERVED_MEM
	dhd_exit_wlan_mem();
#endif /* CONFIG_BROADCOM_WIFI_RESERVED_MEM */
	return 0;
}
