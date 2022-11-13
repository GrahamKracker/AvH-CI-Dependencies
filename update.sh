#!/usr/bin/env bash
cd "$(dirname "$0")" || exit

dotnet tool install --global DeepStrip
PATH=$PATH:~/.dotnet/tools

AvH=$(< ../AvH.targets sed -En 's:.*<AvH>(.*)</AvH>.*:\1:p')
DLLS=$(< ../AvH.targets sed -En 's:.*Reference Include="\$\(ManagedFolder\)\\(.*\.dll)".*:\1:p')


for dll in $DLLS
do
  REAL_DLL="$AvH/Apes vs Helium_Data/Managed/$dll"
  STRIPPED_DLL="./$dll"
  
  deepstrip "$REAL_DLL" "$STRIPPED_DLL"
  echo Deep stripped "$REAL_DLL to $STRIPPED_DLL"
done


read -r -n 1 -p "Press Any Key to exit"