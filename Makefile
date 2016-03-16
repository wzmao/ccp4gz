
EXIST1="$(shell if [ ! -d "/usr/local/lib/vmd" ]; then echo "notexist"; else echo "exist"; fi;)"
EXIST2="$(shell if [ ! -d "$(HOME)/.local/lib/vmd" ]; then echo "notexist"; else echo "exist"; fi;)"
ifeq ($(EXIST1), "exist")
	VMDINCLUDE="-I/usr/local/lib/vmd/plugins/include"
	TO="$(shell find /usr/local/lib/vmd/plugins -type d|grep include -v|grep noarch -v|grep molfile|head -n 1;)"
endif
ifeq ($(EXIST2), "exist")
	VMDINCLUDE="-I$(HOME)/.local/lib/vmd/plugins/include"
	TO="$(shell find $(HOME)/.local/lib/vmd/plugins -type d|grep include -v|grep noarch -v|grep molfile|head -n 1;)"
endif

install:
	gcc -m32 -O3 -fPIC -shared $(VMDINCLUDE) -Icompile ./molfile_plugin/ccp4gz.cpp -lz -o ccp4gzplugin.so
	cp ccp4gzplugin.so $(TO)
