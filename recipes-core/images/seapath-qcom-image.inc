# Copyright (C) 2026 Savoir-faire Linux, Inc.
# SPDX-License-Identifier: Apache-2.0

# Qualcomm boards need to have a ext4 image
IMAGE_FSTYPES:append:qcom = " ext4 qcomflash"
# wic generation is not compatible with qualcomm image deploy
IMAGE_FSTYPES:remove:qcom = "wic.gz"
IMAGE_FSTYPES:remove:qcom = "wic.bmap"
IMAGE_FSTYPES:remove:qcom = "wic.qcow2"

do_tar_image_boot_directory:qcom() {
    tar -cJhf ${IMGDEPLOYDIR}/${IMAGE_BASENAME}-boot.tar.xz -C ${IMAGE_ROOTFS}/boot ./EFI ./Image
}

do_generate_seapath_metadata:qcom() {
}
