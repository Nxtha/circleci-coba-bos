#! /bin/bash 
KernelBranch="18.1-edit"

IncludeFiles "${MainPath}/device/x01bd.sh"
CustomUploader="N"
UseSpectrum="Y"
IncludeFiles "${MainPath}/misc/kernel.sh" "https://${GIT_SECRET}@github.com/${GIT_USERNAME}/x01bd-r"
FolderUp="xobod-r"
doSFUp=$FolderUp
TypeBuildTag="R"
spectrumFile="personal.rc"

CloneKernel "--depth=1"
#CloneCompiledGccEleven
CloneProtonClang
CompileProtonClangKernel && CleanOut
# CloneDTCClang
# CompileClangKernel && CleanOut
# CompileGccKernel && CleanOut

