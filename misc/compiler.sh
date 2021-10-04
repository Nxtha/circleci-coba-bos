#! /bin/bash

CloneGugelClang(){
    [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
    if [ ! -d "${ClangPath}" ];then
        git clone https://github.com/ZyCromerZ/google-clang -b 9.0.4-r353983d "${ClangPath}" --depth=1
    else
        cd "${ClangPath}"
        git fetch https://github.com/ZyCromerZ/google-clang 9.0.4-r353983d --depth=1
        git checkout FETCH_HEAD
        [[ ! -z "$(git branch | grep 9.0.4-r353983d)" ]] && git branch -D 9.0.4-r353983d
        git checkout -b 9.0.4-r353983d
    fi
    TypeBuilder="CLANG"
    ClangType="$(${ClangPath}/bin/clang --version | head -n 1)"
}

CloneOldDTCClang(){
    [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
    if [ ! -d "${ClangPath}" ];then
        git clone https://github.com/nibaji/DragonTC-8.0 -b master "${ClangPath}" --depth=1
    else
        cd "${ClangPath}"
        git fetch https://github.com/nibaji/DragonTC-8.0 master --depth=1
        git checkout FETCH_HEAD
        [[ ! -z "$(git branch | grep master)" ]] && git branch -D master
        git checkout -b master
    fi
    TypeBuilder="DTC-OLD"
    ClangType="$(${ClangPath}/bin/clang --version | head -n 1)"
}

CloneDTCClang(){
    [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
    if [ ! -d "${ClangPath}" ];then
        git clone https://github.com/NusantaraDevs/DragonTC -b 10.0 "${ClangPath}" --depth=1
    else
        cd "${ClangPath}"
        git fetch https://github.com/NusantaraDevs/DragonTC 10.0 --depth=1
        git checkout FETCH_HEAD
        [[ ! -z "$(git branch | grep 10.0)" ]] && git branch -D 10.0
        git checkout -b 10.0
    fi
    TypeBuilder="DTC"
    ClangType="$(${ClangPath}/bin/clang --version | head -n 1)"
}

CloneProtonClang(){
    [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
    if [ ! -d "${ClangPath}" ];then
        git clone https://github.com/kdrag0n/proton-clang -b master "${ClangPath}" --depth=1
    else
        cd "${ClangPath}"
        git fetch https://github.com/kdrag0n/proton-clang master --depth=1
        git checkout FETCH_HEAD
        [[ ! -z "$(git branch | grep master)" ]] && git branch -D master
        git checkout -b master
    fi
    TypeBuilder="Proton"
    ClangType="$(${ClangPath}/bin/clang --version | head -n 1)"
}

CloneStrixClang(){
    [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
    if [ ! -d "${ClangPath}" ];then
        git clone https://github.com/STRIX-Project/STRIX-clang -b main "${ClangPath}" --depth=1
    else
        cd "${ClangPath}"
        git fetch https://github.com/STRIX-Project/STRIX-clang main --depth=1
        git checkout FETCH_HEAD
        [[ ! -z "$(git branch | grep main)" ]] && git branch -D main
        git checkout -b main
    fi
    TypeBuilder="STRIX"
    ClangType="$(${ClangPath}/bin/clang --version | head -n 1)"
}

CloneGCCTenRepo(){
    [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
    GCCaPath="${MainGCCaPath}"
    if [ ! -d "$GCCaPath" ];then
        git clone https://github.com/RyuujiX/aarch64-linux-gnu -b stable-gcc $GCCaPath --depth=1
    else
        cd "${GCCaPath}"
        git fetch https://github.com/RyuujiX/aarch64-linux-gnu -b stable-gcc --depth=1
        git checkout FETCH_HEAD
        [[ ! -z "$(git branch | grep stable-gcc)" ]] && git branch -D stable-gcc
        git checkout -b stable-gcc
    fi
    for64=aarch64-linux-android
    [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
    GCCbPath="${MainGCCbPath}"
    if [ ! -d "$GCCbPath" ];then
        git clone https://github.com/RyuujiX/arm-linux-gnueabi -b stable-gcc $GCCbPath --depth=1
    else
        cd "${GCCbPath}"
        git fetch https://github.com/RyuujiX/arm-linux-gnueabi -b stable-gcc --depth=1
        git checkout FETCH_HEAD
        [[ ! -z "$(git branch | grep stable-gcc)" ]] && git branch -D stable-gcc
        git checkout -b stable-gcc
    fi
    for32=arm-linux-androideabi
    GetGccVersion
}

CloneCompiledGcc(){
    [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
    GCCaPath="$MainZipGCCaPath"
    GCCbPath="$MainZipGCCbPath"
    rm -rf ${GCCaPath}/aarch64-linux-gnu ${GCCbPath}/arm-linux-gnueabi
    mkdir "${GCCaPath}"
    mkdir "${GCCbPath}"
    rm -rf ${GCCaPath}/* ${GCCbPath}/*
    if [ ! -e "${MainPath}/arm-linux-gnueabi-10.x-gnu-20210311.tar.gz" ];then
        wget -q https://gcc-drive.zyc-files.workers.dev/0:/arm-linux-gnueabi-10.x-gnu-20210311.tar.gz
    fi
    tar -xf arm-linux-gnueabi-10.x-gnu-20210311.tar.gz -C $GCCbPath
    GCCbPath="${GCCbPath}/arm-linux-gnueabi"
    for32=arm-linux-gnueabi
    if [ ! -e "${MainPath}/aarch64-linux-gnu-10.x-gnu-20210311.tar.gz" ];then
        wget -q https://gcc-drive.zyc-files.workers.dev/0:/aarch64-linux-gnu-10.x-gnu-20210311.tar.gz
    fi
    tar -xf aarch64-linux-gnu-10.x-gnu-20210311.tar.gz -C $GCCaPath
    GCCaPath="${GCCaPath}/aarch64-linux-gnu"
    for64=aarch64-linux-gnu
    GetGccVersion
}

# CloneCompiledGccEleven(){
#     [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
#     GCCaPath="$MainZipGCCaPath"
#     GCCbPath="$MainZipGCCbPath"
#     rm -rf ${GCCaPath}/* ${GCCbPath}/*
#     mkdir "${GCCaPath}"
#     mkdir "${GCCbPath}"
#     if [ ! -e "${MainPath}/arm-zyc-linux-gnueabi-11.x-gnu-20210905.tar.gz" ];then
#         wget -q  https://github.com/ZyCromerZ/compiled-gcc/releases/download/varm-zyc-linux-gnueabi-11.x-gnu-20210905/arm-zyc-linux-gnueabi-11.x-gnu-20210905.tar.gz
#     fi
#     tar -xf arm-zyc-linux-gnueabi-11.x-gnu-20210905.tar.gz -C $GCCbPath
#     GCCbPath="${GCCbPath}/arm-zyc-linux-gnueabi"
#     for32=arm-zyc-linux-gnueabi
#     if [ ! -e "${MainPath}/aarch64-zyc-linux-gnu-11.x-gnu-20210905.tar.gz" ];then
#         wget -q https://github.com/ZyCromerZ/compiled-gcc/releases/download/vaarch64-zyc-linux-gnu-11.x-gnu-20210905/aarch64-zyc-linux-gnu-11.x-gnu-20210905.tar.gz
#     fi
#     tar -xf aarch64-zyc-linux-gnu-11.x-gnu-20210905.tar.gz -C $GCCaPath
#     GCCaPath="${GCCaPath}/aarch64-zyc-linux-gnu"
#     for64=aarch64-zyc-linux-gnu
#     GetGccVersion
# }


CloneCompiledGccEleven(){
    [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
    GCCaPath="${MainGCCaPath}"
    if [ ! -d "$GCCaPath" ];then
        git clone https://github.com/ZyCromerZ/aarch64-zyc-linux-gnu -b 11 $GCCaPath --depth=1
    else
        cd "${GCCaPath}"
        git fetch https://github.com/ZyCromerZ/aarch64-zyc-linux-gnu -b 11 --depth=1
        git checkout FETCH_HEAD
        [[ ! -z "$(git branch | grep 11)" ]] && git branch -D 11
        git checkout -b 11
    fi
    for64=aarch64-zyc-linux-gnu
    [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
    GCCbPath="${MainGCCbPath}"
    if [ ! -d "$GCCbPath" ];then
        git clone https://github.com/ZyCromerZ/arm-zyc-linux-gnueabi -b 11 $GCCbPath --depth=1
    else
        cd "${GCCbPath}"
        git fetch https://github.com/ZyCromerZ/arm-zyc-linux-gnueabi -b 11 --depth=1
        git checkout FETCH_HEAD
        [[ ! -z "$(git branch | grep 11)" ]] && git branch -D 11
        git checkout -b 11
    fi
    for32=arm-zyc-linux-gnueabi
    GetGccVersion
}


CloneGCCOld(){
    [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
    GCCaPath="${MainGCCaPath}"
    if [ ! -d "$GCCaPath" ];then
        git clone https://github.com/ZyCromerZ/aarch64-linux-android-4.9 -b android-10.0.0_r47 $GCCaPath --depth=1
    else
        cd "${GCCaPath}"
        git fetch https://github.com/ZyCromerZ/aarch64-linux-android-4.9 -b android-10.0.0_r47 --depth=1
        git checkout FETCH_HEAD
        [[ ! -z "$(git branch | grep android-10.0.0_r47)" ]] && git branch -D android-10.0.0_r47
        git checkout -b android-10.0.0_r47
    fi
    for64=aarch64-linux-android
    [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
    GCCbPath="${MainGCCbPath}"
    if [ ! -d "$GCCbPath" ];then
        git clone https://github.com/ZyCromerZ/arm-linux-androideabi-4.9 -b android-10.0.0_r47 $GCCbPath --depth=1
    else
        cd "${GCCbPath}"
        git fetch https://github.com/ZyCromerZ/arm-linux-androideabi-4.9 -b android-10.0.0_r47 --depth=1
        git checkout FETCH_HEAD
        [[ ! -z "$(git branch | grep android-10.0.0_r47)" ]] && git branch -D android-10.0.0_r47
        git checkout -b android-10.0.0_r47
    fi
    for32=arm-linux-androideabi
    GetGccVersion
}

CloneGccten(){
    [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
    GCCaPath="$MainZipGCCaPath"
    GCCbPath="$MainZipGCCbPath"
    mkdir "${GCCaPath}"
    mkdir "${GCCbPath}"
    rm -rf ${GCCaPath}/* ${GCCbPath}/*
    if [ ! -e "${MainPath}/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf.tar.xz" ];then
        wget -q https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-a/10.2-2020.11/binrel/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf.tar.xz
        tar -xf gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf.tar.xz -C $GCCbPath
    fi
    GCCbPath="${GCCbPath}/gcc-arm-10.2-2020.11-x86_64-arm-none-linux-gnueabihf"
    for32=arm-none-linux-gnueabihf
    if [ ! -e "${MainPath}/gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf.tar.xz" ];then
        wget -q https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-a/10.2-2020.11/binrel/gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf.tar.xz
        tar -xf gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf.tar.xz -C $GCCaPath
    fi
    GCCaPath="${GCCaPath}/gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf"
    for64=aarch64-none-elf
    GetGccVersion
}

# CloneCompiledGccTwelve(){
#     [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
#     GCCaPath="$MainZipGCCaPath"
#     GCCbPath="$MainZipGCCbPath"
#     rm -rf ${GCCaPath}/* ${GCCbPath}/*
#     mkdir "${GCCaPath}"
#     mkdir "${GCCbPath}"
#     if [ ! -e "${MainPath}/arm-zyc-linux-gnueabi-12.x-gnu-20210920.tar.gz" ];then
#         wget -q  https://github.com/ZyCromerZ/compiled-gcc/releases/download/varm-zyc-linux-gnueabi-12.x-gnu-20210920/arm-zyc-linux-gnueabi-12.x-gnu-20210920.tar.gz
#     fi
#     tar -xf arm-zyc-linux-gnueabi-12.x-gnu-20210920.tar.gz -C $GCCbPath
#     GCCbPath="${GCCbPath}/arm-zyc-linux-gnueabi"
#     for32=arm-zyc-linux-gnueabi
#     if [ ! -e "${MainPath}/aarch64-zyc-linux-gnu-12.x-gnu-20210920.tar.gz" ];then
#         wget -q https://github.com/ZyCromerZ/compiled-gcc/releases/download/vaarch64-zyc-linux-gnu-12.x-gnu-20210920/aarch64-zyc-linux-gnu-12.x-gnu-20210920.tar.gz
#     fi
#     tar -xf aarch64-zyc-linux-gnu-12.x-gnu-20210920.tar.gz -C $GCCaPath
#     GCCaPath="${GCCaPath}/aarch64-zyc-linux-gnu"
#     for64=aarch64-zyc-linux-gnu
#     GetGccVersion
# }


CloneCompiledGccTwelve(){
    [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
    GCCaPath="${MainGCCaPath}"
    if [ ! -d "$GCCaPath" ];then
        git clone https://github.com/ZyCromerZ/aarch64-zyc-linux-gnu -b 12 $GCCaPath --depth=1
    else
        cd "${GCCaPath}"
        git fetch https://github.com/ZyCromerZ/aarch64-zyc-linux-gnu -b 12 --depth=1
        git checkout FETCH_HEAD
        [[ ! -z "$(git branch | grep 12)" ]] && git branch -D 12
        git checkout -b 12
    fi
    for64=aarch64-zyc-linux-gnu
    [[ "$(pwd)" != "${MainPath}" ]] && cd "${MainPath}"
    GCCbPath="${MainGCCbPath}"
    if [ ! -d "$GCCbPath" ];then
        git clone https://github.com/ZyCromerZ/arm-zyc-linux-gnueabi -b 12 $GCCbPath --depth=1
    else
        cd "${GCCbPath}"
        git fetch https://github.com/ZyCromerZ/arm-zyc-linux-gnueabi -b 12 --depth=1
        git checkout FETCH_HEAD
        [[ ! -z "$(git branch | grep 12)" ]] && git branch -D 12
        git checkout -b 12
    fi
    for32=arm-zyc-linux-gnueabi
    GetGccVersion
}

GetGccVersion()
{
    if [ -e $GCCbPath/bin/$for32-gcc ];then
        gcc32Type="$($GCCbPath/bin/$for32-gcc --version | head -n 1)"
    else
        cd ${GCCbPath}
        gcc32Type=$(git log --pretty=format:'%h: %s' -n1)
        cd ${MainPath}
    fi
    if [ -e $GCCaPath/bin/$for64-gcc ];then
        gcc64Type="$($GCCaPath/bin/$for64-gcc --version | head -n 1)"
    else
        cd ${GCCaPath}
        gcc64Type=$(git log --pretty=format:'%h: %s' -n1)
        cd ${MainPath}
    fi
}