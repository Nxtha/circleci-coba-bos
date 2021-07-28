#! /bin/bash 
KernelBranch="raksasa-test"

IncludeFiles "${MainPath}/device/x01bd.sh"
CustomUploader="N"
UseSpectrum="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/x01bd-r"
FolderUp="xobod-r"
doSFUp=$FolderUp
TypeBuildTag="R"
spectrumFile="private.rc"

CloneKernel "--depth=1"
CloneCompiledGccTwelve
CloneProtonClang
CompileClangKernel && CleanOut
# CloneDTCClang
# CompileClangKernel && CleanOut
# CompileGccKernel && CleanOut

