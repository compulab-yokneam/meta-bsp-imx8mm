include rt.inc

python (){
    import re

    if bb.utils.contains('IMAGE_FEATURES', 'realtime-kernel', False, True, d):
        return

    PV = d.getVar("PV")
    major_dot_minor_dot_fix = re.sub(r'\+.*$', '',  PV)

    rt_patch_uri = d.getVar('RT_PATCH_URI')
    if re.search(r'patch-' + major_dot_minor_dot_fix + '-rt', rt_patch_uri):
        d.appendVar("SRC_URI"," " + rt_patch_uri + " ")
    else:
        patch_name = re.search(r'^.*(patch-[\.0-9]*-rt[\.0-9]*\.patch).*$',rt_patch_uri)
        if patch_name:
            bb.error("RT patch: " + patch_name.group(1))
            bb.error("Kernel revision to build: " + major_dot_minor_dot_fix)
            bb.error("Please find an appropriate patch on https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt")
        #bb.fatal("RT patch revision doesn't match the kernel revision we are about to build")
}
