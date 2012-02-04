#!/bin/sh

# INTER-Mediator Distribution File Builder by Masayuki Nii
#    Execute for current directory as the root of repository.

YUICOMP="../yuicompressor-2.4.7.jar"

echo "Enter version number (don't include ver. or VER. etc) --> "
read version

dt=`date "+%Y-%m-%d"`
versionInFilename=`echo "${version}" | tr '.' '_'`;

curpath=$(cd $(dirname "$0"); pwd)
echo "Working Directory is:", ${curpath}
cd "${curpath}"

cat << EOF > "${curpath}"/sedrule
s/@@@@1@@@@/${dt}/
s/@@@@2@@@@/${version}/
EOF

rm -r ../temp
mkdir ../temp
cd ../temp
cp "${curpath}"/dist-docs/*.txt .
cp "${curpath}"/dist-docs/TestDB.fp7 .

mkdir develop-im
for DIR in `ls "${curpath}"/develop-im`
do
    if [ -f "${curpath}/develop-im/${DIR}" ]; then
        sed -f "${curpath}/sedrule" "${curpath}/develop-im/${DIR}" > "develop-im/${DIR}"
    else
        mkdir "develop-im/${DIR}"
        for FILE in `ls "${curpath}/develop-im/${DIR}"`
        do
            if [ -f "${curpath}/develop-im/${DIR}/${FILE}" ]; then
            sed -f "${curpath}/sedrule" "${curpath}/develop-im/${DIR}/${FILE}" > "develop-im/${DIR}/${FILE}"
            fi
        done
    fi
done

cp -r "${curpath}"/develop-im/Sample_products/images develop-im/Sample_products/
cp -r "${curpath}"/develop-im/INTER-Mediator/FX      develop-im/INTER-Mediator/

echo "######### Marge JavaScript program"
cat develop-im/INTER-Mediator/INTER-Mediator-Lib.js   > temp.js
cat develop-im/INTER-Mediator/INTER-Mediator-Page.js >> temp.js
cat develop-im/INTER-Mediator/INTER-Mediator.js      >> temp.js
rm develop-im/INTER-Mediator/INTER-Mediator-Lib.js
rm develop-im/INTER-Mediator/INTER-Mediator-Page.js
rm develop-im/INTER-Mediator/INTER-Mediator.js

echo "######### Compress INTER-Mediator.js"
java -jar ${YUICOMP} temp.js -v --charset UTF-8 -o develop-im/INTER-Mediator/INTER-Mediator.js

echo "######### Compress Adapter_DBServer.js"
java -jar ${YUICOMP} develop-im/INTER-Mediator/Adapter_DBServer.js --charset UTF-8 -o temp.js
mv -f temp.js develop-im/INTER-Mediator/Adapter_DBServer.js

echo "######### Compress Adapter_LocalDB"
java -jar ${YUICOMP} develop-im/INTER-Mediator/Adapter_LocalDB.js --charset UTF-8 -o temp.js
mv -f temp.js develop-im/INTER-Mediator/Adapter_LocalDB.js

find . -name "\.*"

#rm -rf develop-im/INTER-Mediator/FX
zip -r INTER-Mediator-${versionInFilename}.zip *.txt TestDB.fp7 develop-im
rm "${curpath}"/sedrule

