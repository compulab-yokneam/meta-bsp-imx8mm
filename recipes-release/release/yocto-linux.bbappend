SRC_URI += " \ 
	file://README.txt \
	file://README.html \
"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

do_deploy:append() {
    cp ${WORKDIR}/README.txt ${DESTDIR}/
    cp ${WORKDIR}/README.html ${DESTDIR}/development

    rm  ${DESTDIR}/images/*.tar* || :

    cd ${DEPLOY_DIR_IMAGE}/..
    tree --noreport ${RELEASE_NAME} -o ${RELEASE_NAME}.tree
    cd -
}

