#include <linux/module.h>
#include <linux/init.h>
#include <linux/device.h>
#include <linux/ctype.h>
#include <linux/err.h>
#include <linux/kdev_t.h>

static struct class *slot_class;
static struct device *slot_dev;
dd
enum slot_status {
	SLOT_INERT,
	SLOT_REMOVE,
};

static ssize_t value_show(struct device *dev,
	struct device_attribute *attr, char *buf)
{
	return sprintf(buf, "%s\n", "value");
}

static void slot_generate_event(struct device *dev, enum slot_status reason)
{
	char *envp[2];

	switch (reason) {
	case SLOT_INERT:
		envp[0] = "SLOT=insert";
		break;
	case SLOT_REMOVE:
		envp[0] = "SLOT=remove";
		break;
	default:
		envp[0] = "SLOT=unknown";
		break;
	}
	envp[1] = NULL;
	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
}

static ssize_t value_store(struct device *dev,
	struct device_attribute *attr, const char *buf, size_t count)
{
	unsigned long enable;
	sscanf(buf, "%d", &enable);
	if (enable == 1) {
		printk("enable == 1\n");
		slot_generate_event(dev, SLOT_INERT);
	} else {
		printk("enable == 0\n");
		slot_generate_event(dev, SLOT_REMOVE);
	}	
	
	return count;
}

static DEVICE_ATTR(value, 0777, value_show, value_store);

static void __exit slot_exit(void)
{
	class_destroy(slot_class);
}

static int __init slot_init(void)
{
	slot_class = class_create(THIS_MODULE, "slot");
	if (IS_ERR(slot_class)) {
		printk(KERN_WARNING "Unable to create backlight class; errno = %ld\n",
				PTR_ERR(slot_class));
		return PTR_ERR(slot_class);
	}

	slot_dev = device_create(slot_class, NULL, MKDEV(0, 0), NULL, "status");
	
	device_create_file(slot_dev, &dev_attr_value);
	return 0;
}

module_init(slot_init);
module_exit(slot_exit);

