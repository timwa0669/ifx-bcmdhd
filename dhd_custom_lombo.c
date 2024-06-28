/* SPDX-License-Identifier: GPL-2.0 */

#include <osl.h>
#include <dhd_linux.h>
#include <linux/gpio.h>
#include <linux/mmc/core.h>
#include <linux/mmc/card.h>
#include <linux/mmc/host.h>
#include <linux/mmc/sdio_func.h>

#include <mach/lombo_wireless_pm.h>
#include <mach/lombo_mmc.h>

#ifdef CONFIG_BROADCOM_WIFI_RESERVED_MEM
extern int dhd_init_wlan_mem(void);
extern void dhd_exit_wlan_mem(void);
extern void *dhd_wlan_mem_prealloc(int section, unsigned long size);
#endif /* CONFIG_BROADCOM_WIFI_RESERVED_MEM */

static int dhd_wlan_set_power(int on);
static int dhd_wlan_set_reset(int onoff);
static int dhd_wlan_set_carddetect(int present);
static int dhd_wlan_get_mac_addr(unsigned char *buf);
static void *dhd_wlan_get_country_code(char *ccode,
#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 58)) || defined(CUSTOM_COUNTRY_CODE)
	u32 flags
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
	if (on) {
		lombo_wireless_set_power(WL_WIFI, PWR_ON);
		lombo_wireless_set_enable(WL_WIFI, DISABLED);
		msleep(20);
		lombo_wireless_set_enable(WL_WIFI, ENABLED);
		msleep(60);
	} else {
		lombo_wireless_set_enable(WL_WIFI, DISABLED);
		lombo_wireless_set_power(WL_WIFI, PWR_OFF);
		msleep(20);
	}
	return 0;
}

static int dhd_wlan_set_reset(int onoff)
{
	return 0;
}

static int dhd_wlan_set_carddetect(int present)
{
	int err = 0;
#ifdef BCMSDIO
	printk("%s: scanning sdio card via lbsdc_scan_card\n", __FUNCTION__);
	err = lbsdc_scan_card(present);
	if (err)
		printk(KERN_ERR "%s: failed to set carddetect=%d,"
				" err=%d\n", __FUNCTION__, present, err);
#endif /* BCMSDIO */
	return 0;
}

static int dhd_wlan_get_mac_addr(unsigned char *buf)
{
	int err = 0;
	{
		struct ether_addr ea_example = {{0x00, 0x22, 0xCA, 0x33, 0x44, 0x55}};
		bcopy((char *)&ea_example, buf, sizeof(struct ether_addr));
	}
	return err;
}

static void *dhd_wlan_get_country_code(char *ccode
#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 58)) || defined(CUSTOM_COUNTRY_CODE)
		, u32 flags
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

int dhd_wlan_init_gpio(void)
{
	return 0;
}

int dhd_wlan_init(void)
{
	int err = 0;
	printk("%s: Enter\n", __FUNCTION__);
	err = dhd_wlan_init_gpio();
	if (err < 0) {
		printk(KERN_ERR "%s: failed to control gpio,"
				" ret=%d\n", __FUNCTION__, err);
	}

#ifdef CONFIG_BROADCOM_WIFI_RESERVED_MEM
	err = dhd_init_wlan_mem();
	if (err < 0) {
		printk(KERN_ERR "%s: failed to alloc reserved memory,"
				" ret=%d\n", __FUNCTION__, err);
		return err;
	}
#endif /* CONFIG_BROADCOM_WIFI_RESERVED_MEM */
	return err;
}

int dhd_wlan_deinit(void)
{
	printk("%s: Enter\n", __FUNCTION__);
#ifdef CONFIG_BROADCOM_WIFI_RESERVED_MEM
	dhd_exit_wlan_mem();
#endif /* CONFIG_BROADCOM_WIFI_RESERVED_MEM */
	return 0;
}
