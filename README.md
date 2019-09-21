# SignalFx Smart Agent v4.10.0

## Chocolatey Package

This is a chocolatey package I created for use at Stack Overflow. It will take require the SignalFx Smart Agent (win64) `.zip` archive embedded into the package (when running a `choco pack`). Chocolatey works best when the packages contain the software it is managing and doesn't require downloads. But if the need arises, there are helper functions you can use to download and unzip the archive using `Install-ChocolateyZipPackage`.

## Things to know

-  To create this package, you will need Chocolatey installed and run `choco pack` on the root of this repo. 

-  You will need the `.zip` archive placed in the `tools/` before running `choco pack`. Once you create the package, a `.nupkg` file will be created on the root of the directory.

-  Test the install using `choco install signalfx-agent -dv -s .` within the root of this repo.
