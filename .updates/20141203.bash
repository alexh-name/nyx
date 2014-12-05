if [ -e /bin/bash.b ];then
	rm /bin/bash
	mv /bin/bash.b /bin/bash
fi

rm /etc/local.d/bash.*

chmod +x /bin/bash
