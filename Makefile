all:
	docker run --rm -it -v `pwd`:/source alpine:3.3 /bin/ash -c "apk add --no-cache binutils; cd /source; as mbr.S -o build/mbr.o; ld -Ttext 0x7c00 --oformat=binary build/mbr.o -o build/mbr.bin; (dd if=build/mbr.bin count=1 bs=512; dd if=/dev/zero bs=512 count=2879) > img/my_fucking_floppy_image.img"
