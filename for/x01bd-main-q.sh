#! /bin/bash
KernelBranch="private"

IncludeFiles "${MainPath}/device/x01bd.sh"
CustomUploader="N"
UseSpectrum="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/x01bd-q"
FolderUp="xobod-q"
doSFUp=$FolderUp
TypeBuildTag="Q"
spectrumFile="private.rc"

CloneKernel "--depth=1"
CloneCompiledGccTwelve
CloneProtonClang
CompileClangKernel && CleanOut
CloneDTCClang
CompileClangKernel && CleanOut
CompileGccKernel && CleanOut
