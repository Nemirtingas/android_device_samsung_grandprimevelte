	
# for recovery (global)

on init-recovery
	mount /system

	mount -f /cache	
	ls /cache/recovery/	
	ls /cache/fota/	

	unmount /cache	
	exec -f "/system/bin/e2fsck -v -y <dev_node:/cache>"

	mount /cache	
	fcut --limited-file-size=1024k -f /cache/recovery/last_recovery /tmp/recovery_old.tmp

# running --data_resizing with the userdata binaray
on resizing-data
	mount /system

	mount /data
	find -v --print=/tmp/data.list /data
	unmount /data

	loop_begin 2
		exec "/system/bin/e2fsck -y -f -e <dev_node:/data>"
		exec "/system/bin/resize2fs -R <footer_length> <dev_node:/data>"
	loop_end

	mount /data
	df /data
	verfiy_data <dev_node:/data> /data 5
	verfiy_data --size-from-file=/tmp/data.list
	unmount /data
	
# only run command csc_factory
on pre-multi-csc
	precondition define /carrier
	mount -r /carrier
	format /carrier

# all
on exec-multi-csc
	echo 
	echo "-- Appling Multi-CSC..."
	unmount /system
	mount --option=rw /system
	echo "Applied the CSC-code : <salse_code>"
	
	ln -v -r --force-link -f /system/csc/common/system/app/ /system/app/
	cp -y -f -r -v /system/csc/common /

	cmp -r -f /system/csc/common/system/app/ /system/app/

	ln -v -r --force-link -f /system/csc/<salse_code>/system/app/ /system/app/
	cp -y -f -r -v /system/csc/<salse_code>/system /system

	cmp -r -f /system/csc/common/csc/<salse_code>/system/app/ /system/app/
	
	rm -v /system/csc_contents
	ln -v -s /system/csc/<salse_code>/csc_contents /system/csc_contents

	rm -v -r -f --limited-file-size=0 --type=file --except-root-dir /system/priv-app
	rm -v -r -f --limited-file-size=0 --type=file --except-root-dir /system/app
	
	unmount /system
	echo "Successfully applied multi-CSC."

# only run command csc_factory
on exec-multi-csc-data
	unmount -f /system
	mount /data
	cp -y -f -r -v --with-fmode=0644 --with-dmode=0771 --with-owner=system.system /data/csc/common /
	cp -y -f -r -v --with-fmode=0644 --with-dmode=0771 --with-owner=system.system /data/csc/<salse_code> /
	rm -v -r -f --limited-file-size=0 --type=file --except-root-dir /data/app
	rm -v -r -f /data/csc
	unmount /data

# run condition wipe-data and csc_factory
on exec-install-preload
	echo "-- Set Factory Reset done..."
	mount -f /efs
	mkdir -f radio system 0771 /efs/recovery
	write -f /efs/recovery/currentlyFactoryReset "done"
	unmount /efs

	echo "-- Copying media files..."
	mount /data
	mount /system
	mkdir media_rw media_rw 0770 /data/media
	cp -y -r -v -f --with-fmode=0664 --with-dmode=0775 --with-owner=media_rw.media_rw /system/hidden/INTERNAL_SDCARD/ /data/media/
	unmount /data
	mount /data
	cmp -r /system/hidden/INTERNAL_SDCARD/ /data/media/

	echo "--  preload checkin..."
	precondition define /preload

	mount -f /preload
	precondition mounted /preload

	cp -y -r -v -f --with-fmode=0664 --with-dmode=0775 --with-owner=media_rw.media_rw /preload/INTERNAL_SDCARD/ /data/media/
	unmount /data
	mount /data
	cmp -r /preload/INTERNAL_SDCARD/ /data/media/

on post-exec-install-preload
	# for KOR
	mount /system
	precondition file /system/preload
	mount /data
	mkdir system system 0775 /data/app
	cp -y -f -v --with-fmode=0664 --with-owner=system.system /system/preload/*.ppk /data/app/*.apk

