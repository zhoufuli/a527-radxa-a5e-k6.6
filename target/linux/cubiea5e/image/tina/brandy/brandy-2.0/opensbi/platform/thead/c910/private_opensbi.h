/*
 * SPDX-License-Identifier: BSD-2-Clause
 */

#ifndef __PRIVATE_OPENSBI__
#define __PRIVATE_OPENSBI__

#define CFG_SUNXI_CHECK_EN

#define ITEM_OPENSBI_NAME			"opensbi"

/******************************************************************************/
/*               the control information stored in file head                  */
/*         sizeof(struct private_opensbi_head) == 48Bytes = 12Words           */
/******************************************************************************/
struct private_opensbi_head {
	unsigned int  jump_instruction;	/* jumping to real code */
	unsigned char magic[8];			/* ="opensbi" */
	unsigned int  dtb_base;			/* the address of dtb base*/
	unsigned int  uboot_base;		/* the address of uboot base*/
	unsigned int  res3;
	unsigned int  res4;
	unsigned char version[8];			/*"CHKv1.0"*/
	unsigned char platform[8];
	unsigned int opensbi_base;		/* the address of opensbi base*/
};
#endif /* __PRIVATE_OPNSBI__ */
