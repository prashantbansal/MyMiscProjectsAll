for /f %%i in (D:\Kaplan\CopyProject\FileNames.txt) do (echo. > %%i
Copy D:\Kaplan\CopyProject\Source\%%i D:\Kaplan\CopyProject\Destination
)

