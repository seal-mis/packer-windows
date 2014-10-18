if "%1x"=="x" (
  echo "Please specify a box name, eg. windows_7"
  goto :EOF
)
if exist %1_virtualbox.box (
  del /F %1_virtualbox.box
)

packer build -only=virtualbox-iso %1.json

if exist %1_virtualbox.box (
  vagrant box add %1 %1_virtualbox.box --force
  rem del /F %1_virtualbox.box
)
