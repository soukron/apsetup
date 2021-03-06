#!/bin/bash

_curdir=`pwd`
_tmpdir=$_curdir/src
_wget=/usr/bin/wget


# Build cntlm
function buildCntlm() {
	cd ${_tmpdir}
	${_wget} http://switch.dl.sourceforge.net/project/cntlm/cntlm/cntlm%200.92.3/cntlm-0.92.3.tar.gz
	tar xfz cntlm-0.92.3.tar.gz
	cd cntlm-0.92.3
	./configure
	sed -i '/^DESTDIR=/d' Makefile
	sed -i "1iDESTDIR=${_curdir}" Makefile
	make && make install
}

# Build corkscrew
function buildCorkscrew() {
	cd ${_tmpdir}
	${_wget} http://pkgs.fedoraproject.org/repo/pkgs/corkscrew/corkscrew-2.0.tar.gz/35df77e7f0e59c0ec4f80313be52c10a/corkscrew-2.0.tar.gz
	tar xfz corkscrew-2.0.tar.gz
	cd corkscrew-2.0
	./configure --prefix=${_curdir}
	make && make install
}

# Build dnsmasq
function buildDnsmasq() {
	cd ${_tmpdir}
	${_wget} http://www.thekelleys.org.uk/dnsmasq/dnsmasq-2.72.tar.gz
	tar xfz dnsmasq-2.72.tar.gz
	cd dnsmasq-2.72
	sed -i '/^PREFIX/d' Makefile
	sed -i "1iPREFIX=${_curdir}" Makefile
	make && make install
}

# Build hostapd (this may be different for your wifi adapter)
function buildHostapd() {
	cd ${_tmpdir}
	${_wget} https://starterkit-org.googlecode.com/files/wpa_supplicant_hostapd-0.8_rtw_r7475.20130812.tar.gz
	tar xfz wpa_supplicant_hostapd-0.8_rtw_r7475.20130812.tar.gz
	cd wpa_supplicant_hostapd-0.8_rtw_r7475.20130812/hostapd
	sed -i "1iDESTDIR=${_curdir}" Makefile
	make && make install
}


rm -fr ${_tmpdir} && mkdir -p ${_tmpdir}
buildCntlm
buildCorkscrew
buildDnsmasq
buildHostapd

