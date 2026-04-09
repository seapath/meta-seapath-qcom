# Copyright (C) 2026 Savoir-faire Linux, Inc.
# SPDX-License-Identifier: Apache-2.0

# Qualcomm boards need to have a ext4 image
IMAGE_FSTYPES:qcom:append = " ext4"
# wic generation is not compatible with qualcomm image deploy
IMAGE_FSTYPES:qcom:remove = "wic.gz"
IMAGE_FSTYPES:qcom:remove = "wic.bmap"
IMAGE_FSTYPES:qcom:remove = "wic.qcow2"

do_tar_image_boot_directory:qcom() {
    cp -r ${IMAGE_ROOTFS}/EFI ${IMAGE_ROOTFS}/boot/
    tar -cJhf ${IMGDEPLOYDIR}/${IMAGE_BASENAME}-boot.tar.xz -C ${IMAGE_ROOTFS}/boot ./EFI ./Image
}
