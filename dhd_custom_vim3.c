/*
 * Platform Dependent file for Khadas VIM3
 *
 * Portions of this code are copyright (c) 2024 Cypress Semiconductor Corporation
 *
 * Copyright (C) 1999-2018, Broadcom Corporation
 *
 *      Unless you and Broadcom execute a separate written software license
 * agreement governing use of this software, this software is licensed to you
 * under the terms of the GNU General Public License version 2 (the "GPL"),
 * available at http://www.broadcom.com/licenses/GPLv2.php, with the
 * following added to such license:
 *
 *      As a special exception, the copyright holders of this software give you
 * permission to link this software with independent modules, and to copy and
 * distribute the resulting executable under terms of your choice, provided that
 * you also meet, for each linked independent module, the terms and conditions of
 * the license of that module.  An independent module is a module which is not
 * derived from this software.  The special exception does not apply to any
 * modifications of the software.
 *
 *      Notwithstanding the above, under no circumstances may you combine this
 * software in any way with any other Broadcom software provided under a license
 * other than the GPL, without Broadcom's express prior written consent.
 *
 * <<Broadcom-WL-IPTag/Open:>>
 *
 * $Id$
 *
 */

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/platform_device.h>
#include <linux/delay.h>
#include <linux/err.h>
#include <linux/gpio.h>
#include <linux/skbuff.h>
#if defined(CONFIG_WIFI_CONTROL_FUNC)
#include <linux/wlan_plat.h>
#else
#include <linux/version.h>
#include <dhd_linux.h>
#endif /* CONFIG_WIFI_CONTROL_FUNC */
#include <linux/mmc/host.h>
#include <linux/fcntl.h>
#include <linux/fs.h>
#include <linux/of_gpio.h>
#include <dt-bindings/gpio/meson-g12a-gpio.h>

#ifdef CONFIG_BROADCOM_WIFI_RESERVED_MEM
extern int dhd_init_wlan_mem(void);
extern void dhd_exit_wlan_mem(void);
extern void *dhd_wlan_mem_prealloc(int section, unsigned long size);
#endif /* CONFIG_BROADCOM_WIFI_RESERVED_MEM */

#ifndef WIFI_TURNON_DELAY
#define WIFI_TURNON_DELAY	200
#endif /* WIFI_TURNON_DELAY */
int wlan_reg_on = -1;
module_param(wlan_reg_on, int, 0644);

#define DHD_DT_COMPAT_ENTRY             "android,bcmdhd_wlan"
#define WIFI_WLAN_HOST_WAKE_PROPNAME    "wl_host_wake"
#define WIFI_WLAN_REGON_PROPNAME    "wl_reg_on"

#ifdef CONFIG_BCMDHD_OOB_HOST_WAKE
static int wlan_host_wake_up = GPIOA_7;
static int wlan_host_wake_irq = 0;
#endif // endif
int hostwake_param = 426;
module_param(hostwake_param, int, 0644);

int
dhd_wlan_power(int onoff)
{
	printk(KERN_INFO"%s Enter: power %s\n", __func__, onoff ? "on" : "off");

	if (!gpio_is_valid(wlan_reg_on)) {
		printk(KERN_INFO"check wl_regon gpio: %d\n", wlan_reg_on);
		return 0;
	}

	gpio_direction_output(wlan_reg_on, onoff);

	printk(KERN_INFO"current value is %d\n", gpio_get_value(wlan_reg_on));

	return 0;
}

int dhd_wifi_init_gpio(void)
{
	char *wlan_node = DHD_DT_COMPAT_ENTRY;
	struct device_node *root_node = NULL;

	root_node = of_find_compatible_node(NULL, NULL, wlan_node);

	if (root_node) {
		wlan_reg_on = of_get_named_gpio(root_node, WIFI_WLAN_REGON_PROPNAME, 0);
		if (!gpio_is_valid(wlan_reg_on)) {
			printk(KERN_ERR "Could not get WL_REGON gpio from %s, ret = %d\n",
				WIFI_WLAN_REGON_PROPNAME, wlan_reg_on);
		}
		printk(KERN_ERR "read a gpio(%d) for WL_REGON from %s\n",
				wlan_reg_on, WIFI_WLAN_REGON_PROPNAME);
	}

#ifdef CONFIG_BCMDHD_OOB_HOST_WAKE
	if (root_node) {
		wlan_host_wake_up = of_get_named_gpio(root_node, WIFI_WLAN_HOST_WAKE_PROPNAME, 0);
		printk(KERN_ERR "get wlan_host_wake_up = %d\n", wlan_host_wake_up);
	}
	else {
		printk(KERN_ERR "failed to get device node(%s) of BRCM WLAN, use default GPIOs\n",
			DHD_DT_COMPAT_ENTRY);
		wlan_host_wake_up = hostwake_param;
	}

	/* ========== WLAN_HOST_WAKE ============ */
	wlan_host_wake_up = GPIOA_7;
	printk(KERN_INFO "%s: gpio_wlan_host_wake : %d\n", __FUNCTION__, wlan_host_wake_up);

	if (gpio_request_one(wlan_host_wake_up, GPIOF_IN, "WLAN_HOST_WAKE")) {
		printk(KERN_ERR "%s: Faiiled to request gpio %d for WLAN_HOST_WAKE\n",
			__FUNCTION__, wlan_host_wake_up);
			return -ENODEV;
	} else {
		printk(KERN_ERR "%s: gpio_request WLAN_HOST_WAKE done"
			" - WLAN_HOST_WAKE: GPIO %d\n",
			__FUNCTION__, wlan_host_wake_up);
	}

	printk(KERN_INFO "%s: gpio_wlan_host_wake_irq : %d\n", __FUNCTION__, wlan_host_wake_irq);
#endif /* CONFIG_BCMDHD_OOB_HOST_WAKE */
	if (gpio_is_valid(wlan_reg_on)) {
		if (gpio_request_one(wlan_reg_on, GPIOF_OUT_INIT_LOW, "WLAN_REG_ON")) {
			printk(KERN_ERR "%s: Faiiled to request gpio %d for WL_REGON\n",
				__FUNCTION__, wlan_reg_on);
		}
		else {
			dhd_wlan_power(1);
			/* Wait for WIFI_TURNON_DELAY due to power stability */
			msleep(WIFI_TURNON_DELAY);

			printk(KERN_INFO "%s: Initial WL_REG_ON: [%d]\n", __FUNCTION__,
				gpio_get_value(wlan_reg_on));
		}
	}

	return 0;
}

static int
dhd_wlan_reset(int onoff)
{
	return 0;
}

static int
dhd_wlan_set_carddetect(int val)
{
/*
	calling func from carddetect, if it is required.
*/
	return 0;
}

#if defined(CONFIG_BCMDHD_OOB_HOST_WAKE) && defined(CONFIG_BCMDHD_GET_OOB_STATE)
int
dhd_get_wlan_oob_gpio(void)
{
	return gpio_is_valid(wlan_host_wake_up) ?
		gpio_get_value(wlan_host_wake_up) : -1;
}
#endif /* CONFIG_BCMDHD_OOB_HOST_WAKE && CONFIG_BCMDHD_GET_OOB_STATE */

struct resource dhd_wlan_resources = {
	.name	= "bcmdhd_wlan_irq",
	.start	= 0, /* Dummy */
	.end	= 0, /* Dummy */
	.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE |
#ifdef BCMPCIE
	IORESOURCE_IRQ_HIGHEDGE,
#else
	IORESOURCE_IRQ_HIGHLEVEL,
#endif /* BCMPCIE */
};

struct wifi_platform_data dhd_wlan_control = {
	.set_power	= dhd_wlan_power,
	.set_reset	= dhd_wlan_reset,
	.set_carddetect	= dhd_wlan_set_carddetect,
#ifdef CONFIG_BROADCOM_WIFI_RESERVED_MEM
	.mem_prealloc	= dhd_wlan_mem_prealloc,
#endif /* CONFIG_BROADCOM_WIFI_RESERVED_MEM */
};

int dhd_wlan_deinit(void)
{
#ifdef CONFIG_BCMDHD_OOB_HOST_WAKE
	gpio_free(wlan_host_wake_up);
#endif /* CONFIG_BCMDHD_OOB_HOST_WAKE */
	if (wlan_reg_on != -1)
		gpio_free(wlan_reg_on);
#ifdef CONFIG_BROADCOM_WIFI_RESERVED_MEM
	dhd_exit_wlan_mem();
#endif /*  CONFIG_BROADCOM_WIFI_RESERVED_MEM */
	return 0;
}

int dhd_wlan_init(void)
{
	int ret;

	printk(KERN_INFO"%s: START.......\n", __FUNCTION__);
	ret = dhd_wifi_init_gpio();
	if (ret < 0) {
		printk(KERN_ERR "%s: failed to initiate GPIO, ret=%d\n",
			__FUNCTION__, ret);
		goto fail;
	}

#ifdef CONFIG_BCMDHD_OOB_HOST_WAKE
	dhd_wlan_resources.start = wlan_host_wake_irq;
	dhd_wlan_resources.end = wlan_host_wake_irq;
#endif /* CONFIG_BCMDHD_OOB_HOST_WAKE */

#ifdef CONFIG_BROADCOM_WIFI_RESERVED_MEM
	ret = dhd_init_wlan_mem();
	if (ret < 0) {
		printk(KERN_ERR "%s: failed to alloc reserved memory,"
			" ret=%d\n", __FUNCTION__, ret);
	}
#endif /* CONFIG_BROADCOM_WIFI_RESERVED_MEM */

fail:
	printk(KERN_INFO"%s: FINISH.......\n", __FUNCTION__);
	return ret;
}
