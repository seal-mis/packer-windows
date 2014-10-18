if "%1x"=="x" (
  echo "Please specify a box name, eg. windows_7"
  goto :EOF
)
if exist %1_vmware.box (
  del /F %1_vmware.box
)

packer build -only=vmware-iso %1.json

if exist %1_vmware.box (
  vagrant box add %1 %1_vmware.box --force
  rem del /F %1_vmware.box
)
