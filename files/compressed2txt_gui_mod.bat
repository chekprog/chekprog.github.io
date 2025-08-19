@(echo off% <#%) &color 07 &title Compressed2TXT v6.5 - Modern GUI by AveYo
chcp 65001 >nul &set "0=%~f0" &set 1=%*& powershell -nop -sta -c iex ([io.file]::ReadAllText($env:0)); &exit /b ||#>)[1]; $PS={

## Modern GUI for Compressed2TXT - Modified Version
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

## Language Support
$global:currentLanguage = "en"  # Default language: "en" or "ru"

$global:translations = @{
    "en" = @{
        "title" = "Compressed2TXT - Advanced File Encoder"
        "fileSelection" = "File/Folder Selection (or drag & drop here)"
        "addFiles" = "Add Files"
        "addFolder" = "Add Folder"
        "remove" = "Remove"
        "clearAll" = "Clear All"
        "encodingOptions" = "Encoding Options"
        "passwordProtection" = "Password protection"
        "randomizeKey" = "Randomize key"
        "bat85Encoding" = "BAT85 encoding"
        "longLines" = "Long lines"
        "cabOnly" = "CAB only"
        "externalKeyFile" = "External key file"
        "advancedSettings" = "Advanced Settings:"
        "compression" = "Compression:"
        "cryptoName" = "Crypto name:"
        "extractPath" = "Extract path:"
        "processFiles" = "Process Files"
        "exit" = "Exit"
        "language" = "ENG"
        "ready" = "Ready - Select files or folders to encode"
        "added" = "Added"
        "itemsViaDrop" = "item(s) via drag & drop"
        "files" = "file(s)"
        "folder" = "Added folder:"
        "removed" = "Removed"
        "items" = "item(s)"
        "fileListCleared" = "File list cleared"
        "noInput" = "Please select files or folders to process!"
        "noSelection" = "Please select items to remove!"
        "processingFiles" = "Processing files..."
        "completedSuccess" = "Processing completed successfully!"
        "success" = "Files processed successfully!"
        "error" = "Error:"
        "selectFilesToEncode" = "Select Files to Encode"
        "selectFolderToEncode" = "Select Folder to Encode"
        "tooltip1" = "Input decoding key as password"
        "tooltip2" = "Randomize decoding key (use with password)"
        "tooltip3" = "Use BAT85 encoder (web-safe, +1.7% size)"
        "tooltip4" = "Longer lines (less overhead)"
        "tooltip5" = "Create CAB archive only"
        "tooltip6" = "Create separate .key file for decryption"
    }
    "ru" = @{
        "title" = "Compressed2TXT - Продвинутый кодировщик файлов"
        "fileSelection" = "Выбор файлов/папок (или перетащите сюда)"
        "addFiles" = "Добавить файлы"
        "addFolder" = "Добавить папку"
        "remove" = "Удалить"
        "clearAll" = "Очистить всё"
        "encodingOptions" = "Параметры кодирования"
        "passwordProtection" = "Защита паролем"
        "randomizeKey" = "Случайный ключ"
        "bat85Encoding" = "Кодировка BAT85"
        "longLines" = "Длинные строки"
        "cabOnly" = "Только CAB"
        "externalKeyFile" = "Внешний файл ключа"
        "advancedSettings" = "Дополнительные настройки:"
        "compression" = "Сжатие:"
        "cryptoName" = "Имя шифрования:"
        "extractPath" = "Путь извлечения:"
        "processFiles" = "Обработать"
        "exit" = "Выход"
        "language" = "РУС"
        "ready" = "Готов - Выберите файлы или папки для кодирования"
        "added" = "Добавлено"
        "itemsViaDrop" = "элемент(ов) перетаскиванием"
        "files" = "файл(ов)"
        "folder" = "Добавлена папка:"
        "removed" = "Удалено"
        "items" = "элемент(ов)"
        "fileListCleared" = "Список файлов очищен"
        "noInput" = "Пожалуйста, выберите файлы или папки для обработки!"
        "noSelection" = "Пожалуйста, выберите элементы для удаления!"
        "processingFiles" = "Обработка файлов..."
        "completedSuccess" = "Обработка завершена успешно!"
        "success" = "Файлы обработаны успешно!"
        "error" = "Ошибка:"
        "selectFilesToEncode" = "Выберите файлы для кодирования"
        "selectFolderToEncode" = "Выберите папку для кодирования"
        "tooltip1" = "Ввод ключа декодирования как пароль"
        "tooltip2" = "Рандомизировать ключ декодирования (использовать с паролем)"
        "tooltip3" = "Использовать кодировщик BAT85 (безопасный для веб, +1.7% размера)"
        "tooltip4" = "Длинные строки (меньше накладных расходов)"
        "tooltip5" = "Создать только CAB архив"
        "tooltip6" = "Создать отдельный .key файл для расшифровки"
    }
}

function Get-Translation {
    param([string]$key)
    return $global:translations[$global:currentLanguage][$key]
}

function Update-Language {
    $form.Text = (Get-Translation "title")
    $fileGroup.Text = (Get-Translation "fileSelection")
    $browseFilesBtn.Text = (Get-Translation "addFiles")
    $browseFolderBtn.Text = (Get-Translation "addFolder")
    $removeBtn.Text = (Get-Translation "remove")
    $clearBtn.Text = (Get-Translation "clearAll")
    $optionsGroup.Text = (Get-Translation "encodingOptions")
    $checkboxes["password"].Text = (Get-Translation "passwordProtection")
    $checkboxes["random"].Text = (Get-Translation "randomizeKey")
    $checkboxes["bat85"].Text = (Get-Translation "bat85Encoding")
    $checkboxes["longlines"].Text = (Get-Translation "longLines")
    $checkboxes["cabonly"].Text = (Get-Translation "cabOnly")
    $checkboxes["extkey"].Text = (Get-Translation "externalKeyFile")
    $advLabel.Text = (Get-Translation "advancedSettings")
    $compLabel.Text = (Get-Translation "compression")
    $cryptoLabel.Text = (Get-Translation "cryptoName")
    $pathLabel.Text = (Get-Translation "extractPath")
    $processBtn.Text = (Get-Translation "processFiles")
    $exitBtn.Text = (Get-Translation "exit")
    $langBtn.Text = (Get-Translation "language")
    $statusLabel.Text = (Get-Translation "ready")
    $statusLabel.ForeColor = [System.Drawing.Color]::DarkGreen
    
    # Update tooltips
    $global:tooltip1.SetToolTip($checkboxes["password"], (Get-Translation "tooltip1"))
    $global:tooltip2.SetToolTip($checkboxes["random"], (Get-Translation "tooltip2"))
    $global:tooltip3.SetToolTip($checkboxes["bat85"], (Get-Translation "tooltip3"))
    $global:tooltip4.SetToolTip($checkboxes["longlines"], (Get-Translation "tooltip4"))
    $global:tooltip5.SetToolTip($checkboxes["cabonly"], (Get-Translation "tooltip5"))
    $global:tooltip6.SetToolTip($checkboxes["extkey"], (Get-Translation "tooltip6"))
    
    $form.Refresh()
}

$Main={
$env:1; 
$SendTo = [Environment]::GetFolderPath('ApplicationData') + '\Microsoft\Windows\SendTo'

## Save to SendTo menu when run from another location
if (!$env:1 -and $env:0 -notlike '*\SendTo\Compressed 2 TXT*') {
 $BAT='@(echo off% <#%) &color 07 &title Compressed2TXT v6.5 - Modern GUI by AveYo (Modified)'+"`n"
 $BAT+='chcp 850 >nul &set "0=%~f0" &set 1=%*& powershell -nop -c iex ([io.file]::ReadAllText($env:0)); &exit/b ||#>)[1]'
 $BAT+='; $PS={' + $PS + '}; .$PS; .$Main' + "`n#-.-# hybrid script, can be pasted directly into powershell console"
 [IO.File]::WriteAllLines($SendTo + '\Compressed 2 TXT.bat', $BAT -split "`r`n" -split "`n", [Text.Encoding]::ASCII)
}

## Function to transliterate Russian to Latin
function TransliterateRussian {
    param([string]$text)
    
    $result = $text
    
    # Lowercase Cyrillic to Latin
    $result = $result -replace 'а', 'a'
    $result = $result -replace 'б', 'b'
    $result = $result -replace 'в', 'v'
    $result = $result -replace 'г', 'g'
    $result = $result -replace 'д', 'd'
    $result = $result -replace 'е', 'e'
    $result = $result -replace 'ё', 'yo'
    $result = $result -replace 'ж', 'zh'
    $result = $result -replace 'з', 'z'
    $result = $result -replace 'и', 'i'
    $result = $result -replace 'й', 'y'
    $result = $result -replace 'к', 'k'
    $result = $result -replace 'л', 'l'
    $result = $result -replace 'м', 'm'
    $result = $result -replace 'н', 'n'
    $result = $result -replace 'о', 'o'
    $result = $result -replace 'п', 'p'
    $result = $result -replace 'р', 'r'
    $result = $result -replace 'с', 's'
    $result = $result -replace 'т', 't'
    $result = $result -replace 'у', 'u'
    $result = $result -replace 'ф', 'f'
    $result = $result -replace 'х', 'h'
    $result = $result -replace 'ц', 'ts'
    $result = $result -replace 'ч', 'ch'
    $result = $result -replace 'ш', 'sh'
    $result = $result -replace 'щ', 'sch'
    $result = $result -replace 'ъ', ''
    $result = $result -replace 'ы', 'y'
    $result = $result -replace 'ь', ''
    $result = $result -replace 'э', 'e'
    $result = $result -replace 'ю', 'yu'
    $result = $result -replace 'я', 'ya'
    
    # Uppercase Cyrillic to Latin
    $result = $result -replace 'А', 'A'
    $result = $result -replace 'Б', 'B'
    $result = $result -replace 'В', 'V'
    $result = $result -replace 'Г', 'G'
    $result = $result -replace 'Д', 'D'
    $result = $result -replace 'Е', 'E'
    $result = $result -replace 'Ё', 'Yo'
    $result = $result -replace 'Ж', 'Zh'
    $result = $result -replace 'З', 'Z'
    $result = $result -replace 'И', 'I'
    $result = $result -replace 'Й', 'Y'
    $result = $result -replace 'К', 'K'
    $result = $result -replace 'Л', 'L'
    $result = $result -replace 'М', 'M'
    $result = $result -replace 'Н', 'N'
    $result = $result -replace 'О', 'O'
    $result = $result -replace 'П', 'P'
    $result = $result -replace 'Р', 'R'
    $result = $result -replace 'С', 'S'
    $result = $result -replace 'Т', 'T'
    $result = $result -replace 'У', 'U'
    $result = $result -replace 'Ф', 'F'
    $result = $result -replace 'Х', 'H'
    $result = $result -replace 'Ц', 'Ts'
    $result = $result -replace 'Ч', 'Ch'
    $result = $result -replace 'Ш', 'Sh'
    $result = $result -replace 'Щ', 'Sch'
    $result = $result -replace 'Ъ', ''
    $result = $result -replace 'Ы', 'Y'
    $result = $result -replace 'Ь', ''
    $result = $result -replace 'Э', 'E'
    $result = $result -replace 'Ю', 'Yu'
    $result = $result -replace 'Я', 'Ya'
    
    # Replace spaces with underscores and remove invalid characters
    $result = $result -replace '\s+', '_'
    $result = $result -replace '[^\w\-_]', ''
    
    return $result
}

## Create Modern GUI Form - Made wider and dynamic
$form = New-Object System.Windows.Forms.Form
$form.Text = (Get-Translation "title")
$form.Size = New-Object System.Drawing.Size(700, 580)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(240, 240, 240)
$form.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$form.AllowDrop = $true

## Language Toggle Button
$langBtn = New-Object System.Windows.Forms.Button
$langBtn.Text = "EN/РУ"
$langBtn.Location = New-Object System.Drawing.Point(600, 20)
$langBtn.Size = New-Object System.Drawing.Size(60, 25)
$langBtn.BackColor = [System.Drawing.Color]::FromArgb(108, 117, 125)
$langBtn.ForeColor = [System.Drawing.Color]::White
$langBtn.FlatStyle = "Flat"
$langBtn.Font = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($langBtn)

## File Selection Group - Made wider with dynamic sizing
$fileGroup = New-Object System.Windows.Forms.GroupBox
$fileGroup.Text = (Get-Translation "fileSelection")
$fileGroup.Location = New-Object System.Drawing.Point(20, 60)
$fileGroup.Size = New-Object System.Drawing.Size(650, 145)
$fileGroup.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$fileGroup.AllowDrop = $true
$form.Controls.Add($fileGroup)

## Selected files listbox with scrollbar and wider
$fileListBox = New-Object System.Windows.Forms.ListBox
$fileListBox.Location = New-Object System.Drawing.Point(15, 25)
$fileListBox.Size = New-Object System.Drawing.Size(480, 115)
$fileListBox.SelectionMode = "MultiExtended"
$fileListBox.Font = New-Object System.Drawing.Font("Segoe UI", 8)
$fileListBox.AllowDrop = $true
$fileListBox.ScrollAlwaysVisible = $true
$fileListBox.HorizontalScrollbar = $false
$fileGroup.Controls.Add($fileListBox)

## Function to resize listbox dynamically
function ResizeListBox {
    $maxWidth = 480
    $longestItem = 0
    
    foreach ($item in $fileListBox.Items) {
        $itemWidth = [System.Windows.Forms.TextRenderer]::MeasureText($item, $fileListBox.Font).Width
        if ($itemWidth -gt $longestItem) {
            $longestItem = $itemWidth
        }
    }
    
    if ($longestItem -gt $maxWidth) {
        $fileListBox.HorizontalExtent = $longestItem + 20
    }
}

## Browse Files Button
$browseFilesBtn = New-Object System.Windows.Forms.Button
$browseFilesBtn.Text = (Get-Translation "addFiles")
$browseFilesBtn.Location = New-Object System.Drawing.Point(510, 20)
$browseFilesBtn.Size = New-Object System.Drawing.Size(120, 25)
$browseFilesBtn.BackColor = [System.Drawing.Color]::FromArgb(92, 184, 92)
$browseFilesBtn.ForeColor = [System.Drawing.Color]::White
$browseFilesBtn.FlatStyle = "Flat"
$browseFilesBtn.Font = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Bold)
$fileGroup.Controls.Add($browseFilesBtn)

## Browse Folder Button
$browseFolderBtn = New-Object System.Windows.Forms.Button
$browseFolderBtn.Text = (Get-Translation "addFolder")
$browseFolderBtn.Location = New-Object System.Drawing.Point(510, 50)
$browseFolderBtn.Size = New-Object System.Drawing.Size(120, 25)
$browseFolderBtn.BackColor = [System.Drawing.Color]::FromArgb(91, 192, 222)
$browseFolderBtn.ForeColor = [System.Drawing.Color]::White
$browseFolderBtn.FlatStyle = "Flat"
$browseFolderBtn.Font = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Bold)
$fileGroup.Controls.Add($browseFolderBtn)

## Remove Selected Button
$removeBtn = New-Object System.Windows.Forms.Button
$removeBtn.Text = (Get-Translation "remove")
$removeBtn.Location = New-Object System.Drawing.Point(510, 80)
$removeBtn.Size = New-Object System.Drawing.Size(120, 25)
$removeBtn.BackColor = [System.Drawing.Color]::FromArgb(255, 165, 0)
$removeBtn.ForeColor = [System.Drawing.Color]::White
$removeBtn.FlatStyle = "Flat"
$removeBtn.Font = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Bold)
$fileGroup.Controls.Add($removeBtn)

## Clear Button
$clearBtn = New-Object System.Windows.Forms.Button
$clearBtn.Text = (Get-Translation "clearAll")
$clearBtn.Location = New-Object System.Drawing.Point(510, 110)
$clearBtn.Size = New-Object System.Drawing.Size(120, 25)
$clearBtn.BackColor = [System.Drawing.Color]::FromArgb(217, 83, 79)
$clearBtn.ForeColor = [System.Drawing.Color]::White
$clearBtn.FlatStyle = "Flat"
$clearBtn.Font = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Bold)
$fileGroup.Controls.Add($clearBtn)

## Options Group
$optionsGroup = New-Object System.Windows.Forms.GroupBox
$optionsGroup.Text = (Get-Translation "encodingOptions")
$optionsGroup.Location = New-Object System.Drawing.Point(20, 210)
$optionsGroup.Size = New-Object System.Drawing.Size(650, 200)
$optionsGroup.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($optionsGroup)


## Create checkboxes for options with tooltips
$options = @(
    @{Name="password"; Key="passwordProtection"; TooltipKey="tooltip1"},
    @{Name="random"; Key="randomizeKey"; TooltipKey="tooltip2"},
    @{Name="bat85"; Key="bat85Encoding"; TooltipKey="tooltip3"},
    @{Name="longlines"; Key="longLines"; TooltipKey="tooltip4"},
    @{Name="cabonly"; Key="cabOnly"; TooltipKey="tooltip5"},
    @{Name="extkey"; Key="externalKeyFile"; TooltipKey="tooltip6"}
)

$checkboxes = @{}
$tooltips = @{}
$yPos = 25
$col = 0

foreach ($option in $options) {
    $checkbox = New-Object System.Windows.Forms.CheckBox
    $checkbox.Text = Get-Translation $option.Key
    $checkbox.Location = New-Object System.Drawing.Point((20 + $col * 180), $yPos)
    $checkbox.Size = New-Object System.Drawing.Size(170, 25)
    $checkbox.Font = New-Object System.Drawing.Font("Segoe UI", 9)
    $checkbox.Tag = $option.Name
    
    # Add tooltip
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($checkbox, (Get-Translation $option.TooltipKey))
    $tooltips[$option.TooltipKey] = $tooltip
    
    $checkboxes[$option.Name] = $checkbox
    $optionsGroup.Controls.Add($checkbox)
    
    $col++
    if ($col -eq 3) {
        $col = 0
        $yPos += 30
    }
}

# Store tooltips globally for language updates
$global:tooltip1 = $tooltips["tooltip1"]
$global:tooltip2 = $tooltips["tooltip2"]
$global:tooltip3 = $tooltips["tooltip3"]
$global:tooltip4 = $tooltips["tooltip4"]
$global:tooltip5 = $tooltips["tooltip5"]
$global:tooltip6 = $tooltips["tooltip6"]

## Advanced Options
$advLabel = New-Object System.Windows.Forms.Label
$advLabel.Text = (Get-Translation "advancedSettings")
$advLabel.Location = New-Object System.Drawing.Point(20, 115)
$advLabel.Size = New-Object System.Drawing.Size(200, 20)
$advLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$optionsGroup.Controls.Add($advLabel)

## Compression Type - spaced out more
$compLabel = New-Object System.Windows.Forms.Label
$compLabel.Text = (Get-Translation "compression")
$compLabel.Location = New-Object System.Drawing.Point(20, 145)
$compLabel.Size = New-Object System.Drawing.Size(80, 20)
$compLabel.Font = New-Object System.Drawing.Font("Segoe UI", 8)
$optionsGroup.Controls.Add($compLabel)

$compCombo = New-Object System.Windows.Forms.ComboBox
$compCombo.Location = New-Object System.Drawing.Point(105, 143)
$compCombo.Size = New-Object System.Drawing.Size(100, 20)
$compCombo.Items.AddRange(@("LZX", "MSZip", "No compression"))
$compCombo.SelectedIndex = 0
$compCombo.DropDownStyle = "DropDownList"
$optionsGroup.Controls.Add($compCombo)

## Crypto Name with auto-transliteration - spaced out
$cryptoLabel = New-Object System.Windows.Forms.Label
$cryptoLabel.Text = (Get-Translation "cryptoName")
$cryptoLabel.Location = New-Object System.Drawing.Point(250, 145)
$cryptoLabel.Size = New-Object System.Drawing.Size(100, 20)
$cryptoLabel.Font = New-Object System.Drawing.Font("Segoe UI", 8)
$optionsGroup.Controls.Add($cryptoLabel)

$cryptoText = New-Object System.Windows.Forms.TextBox
$cryptoText.Location = New-Object System.Drawing.Point(355, 143)
$cryptoText.Size = New-Object System.Drawing.Size(120, 20)
$cryptoText.Text = "bat2file"
$optionsGroup.Controls.Add($cryptoText)

## Auto-transliterate crypto name
$cryptoText.Add_TextChanged({
    $cursorPos = $cryptoText.SelectionStart
    $originalText = $cryptoText.Text
    $transliteratedText = TransliterateRussian -text $originalText
    
    if ($originalText -ne $transliteratedText) {
        $cryptoText.Text = $transliteratedText
        $cryptoText.SelectionStart = [Math]::Min($cursorPos, $transliteratedText.Length)
    }
})

## Path Folder - wider and better spaced
$pathLabel = New-Object System.Windows.Forms.Label
$pathLabel.Text = (Get-Translation "extractPath")
$pathLabel.Location = New-Object System.Drawing.Point(20, 175)
$pathLabel.Size = New-Object System.Drawing.Size(80, 20)
$pathLabel.Font = New-Object System.Drawing.Font("Segoe UI", 8)
$optionsGroup.Controls.Add($pathLabel)

$pathText = New-Object System.Windows.Forms.TextBox
$pathText.Location = New-Object System.Drawing.Point(105, 173)
$pathText.Size = New-Object System.Drawing.Size(300, 20)
$pathText.Text = "%~dp0"
$optionsGroup.Controls.Add($pathText)

## Progress Bar - adjusted position and size
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(20, 420)
$progressBar.Size = New-Object System.Drawing.Size(650, 20)
$progressBar.Style = "Continuous"
$form.Controls.Add($progressBar)

## Status Label - adjusted position and size
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = (Get-Translation "ready")
$statusLabel.Location = New-Object System.Drawing.Point(20, 445)
$statusLabel.Size = New-Object System.Drawing.Size(650, 20)
$statusLabel.Font = New-Object System.Drawing.Font("Segoe UI", 8)
$statusLabel.ForeColor = [System.Drawing.Color]::DarkGreen
$form.Controls.Add($statusLabel)

## Action Buttons - centered
$processBtn = New-Object System.Windows.Forms.Button
$processBtn.Text = (Get-Translation "processFiles")
$processBtn.Location = New-Object System.Drawing.Point(420, 475)
$processBtn.Size = New-Object System.Drawing.Size(120, 35)
$processBtn.BackColor = [System.Drawing.Color]::FromArgb(51, 122, 183)
$processBtn.ForeColor = [System.Drawing.Color]::White
$processBtn.FlatStyle = "Flat"
$processBtn.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($processBtn)

$exitBtn = New-Object System.Windows.Forms.Button
$exitBtn.Text = (Get-Translation "exit")
$exitBtn.Location = New-Object System.Drawing.Point(560, 475)
$exitBtn.Size = New-Object System.Drawing.Size(80, 35)
$exitBtn.BackColor = [System.Drawing.Color]::FromArgb(108, 117, 125)
$exitBtn.ForeColor = [System.Drawing.Color]::White
$exitBtn.FlatStyle = "Flat"
$exitBtn.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($exitBtn)

## Language Toggle Event
$langBtn.Add_Click({
    if ($global:currentLanguage -eq "en") {
        $global:currentLanguage = "ru"
    } else {
        $global:currentLanguage = "en"
    }
    Update-Language
})

## Auto-transliterate crypto name
$cryptoText.Add_TextChanged({
    $cursorPos = $cryptoText.SelectionStart
    $originalText = $cryptoText.Text
    $transliteratedText = TransliterateRussian -text $originalText
    
    if ($originalText -ne $transliteratedText) {
        $cryptoText.Text = $transliteratedText
        $cryptoText.SelectionStart = [Math]::Min($cursorPos, $transliteratedText.Length)
    }
})

## Drag and Drop Event Handlers
$form.Add_DragEnter({
    param($sender, $e)
    if ($e.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)) {
        $e.Effect = [Windows.Forms.DragDropEffects]::Copy
    }
})

$form.Add_DragDrop({
    param($sender, $e)
    $files = $e.Data.GetData([Windows.Forms.DataFormats]::FileDrop)
    foreach ($file in $files) {
        if (!$fileListBox.Items.Contains($file)) {
            $fileListBox.Items.Add($file)
        }
    }
    ResizeListBox
    $statusLabel.Text = ((Get-Translation "added")) + " " + $files.Count + " " + ((Get-Translation "itemsViaDrop"))
})

$fileListBox.Add_DragEnter({
    param($sender, $e)
    if ($e.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)) {
        $e.Effect = [Windows.Forms.DragDropEffects]::Copy
    }
})

$fileListBox.Add_DragDrop({
    param($sender, $e)
    $files = $e.Data.GetData([Windows.Forms.DataFormats]::FileDrop)
    foreach ($file in $files) {
        if (!$fileListBox.Items.Contains($file)) {
            $fileListBox.Items.Add($file)
        }
    }
    ResizeListBox
    $statusLabel.Text = ((Get-Translation "added")) + " " + $files.Count + " " + ((Get-Translation "itemsViaDrop"))
})

## Event Handlers

# Browse Files
$browseFilesBtn.Add_Click({
    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.Multiselect = $true
    $openFileDialog.Title = (Get-Translation "selectFilesToEncode")
    $openFileDialog.Filter = "All Files (*.*)|*.*"
    
    if ($openFileDialog.ShowDialog() -eq "OK") {
        foreach ($file in $openFileDialog.FileNames) {
            if (!$fileListBox.Items.Contains($file)) {
                $fileListBox.Items.Add($file)
            }
        }
        ResizeListBox
        $statusLabel.Text = ((Get-Translation "added")) + " " + $openFileDialog.FileNames.Count + " " + ((Get-Translation "files"))
    }
})

# Browse Folder
$browseFolderBtn.Add_Click({
    $folderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderDialog.Description = (Get-Translation "selectFolderToEncode")
    
    if ($folderDialog.ShowDialog() -eq "OK") {
        if (!$fileListBox.Items.Contains($folderDialog.SelectedPath)) {
            $fileListBox.Items.Add($folderDialog.SelectedPath)
        }
        ResizeListBox
        $statusLabel.Text = ((Get-Translation "folder")) + " " + (Split-Path $folderDialog.SelectedPath -Leaf)
    }
})

# Remove Selected Items
$removeBtn.Add_Click({
    $selectedIndices = @()
    for ($i = $fileListBox.SelectedIndices.Count - 1; $i -ge 0; $i--) {
        $selectedIndices += $fileListBox.SelectedIndices[$i]
    }
    
    if ($selectedIndices.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show(((Get-Translation "noSelection")), "No Selection", "OK", "Warning")
        return
    }
    
    foreach ($index in $selectedIndices | Sort-Object -Descending) {
        $fileListBox.Items.RemoveAt($index)
    }
    
    ResizeListBox
    $statusLabel.Text = ((Get-Translation "removed")) + " " + $selectedIndices.Count + " " + ((Get-Translation "items"))
})

# Clear Files
$clearBtn.Add_Click({
    $fileListBox.Items.Clear()
    $statusLabel.Text = (Get-Translation "fileListCleared")
})

# Exit
$exitBtn.Add_Click({
    $form.Close()
})

# Process Files
$processBtn.Add_Click({
    if ($fileListBox.Items.Count -eq 0) {
        [System.Windows.Forms.MessageBox]::Show(((Get-Translation "noInput")), "No Input", "OK", "Warning")
        return
    }
    
    # Disable UI during processing
    $processBtn.Enabled = $false
    $browseFilesBtn.Enabled = $false
    $browseFolderBtn.Enabled = $false
    $removeBtn.Enabled = $false
    $clearBtn.Enabled = $false
    $langBtn.Enabled = $false
    $progressBar.Value = 10
    $statusLabel.Text = (Get-Translation "processingFiles")
    $form.Refresh()
    
    try {
        # Collect selected items
        $selectedFiles = @()
        foreach ($item in $fileListBox.Items) {
            $selectedFiles += $item
        }
        
        # Build argument string for processing
        $argString = ""
        foreach ($file in $selectedFiles) {
            $argString += "`"$file`" "
        }
        $env:1 = $argString.Trim()
        
        # Collect choices
        $choices = @()
        foreach ($checkbox in $checkboxes.Values) {
            if ($checkbox.Checked) {
                $choices += $checkbox.Tag
            }
        }
        
        # Add compression choice
        if ($compCombo.SelectedItem -eq "MSZip") {
            $choices += "cpres"
        } elseif ($compCombo.SelectedItem -eq "No compression") {
            $choices += "nocompress"
        }
        
        $progressBar.Value = 20
        $statusLabel.Text = "Setting up parameters..."
        $form.Refresh()
        
        # Process using original logic
        ProcessFilesOriginal -choices $choices -cryptoName $cryptoText.Text -pathFolder $pathText.Text -progressCallback {
            param($percent, $message)
            $progressBar.Value = [Math]::Min($percent, 100)
            $statusLabel.Text = $message
            $form.Refresh()
        }
        
        $progressBar.Value = 100
        $statusLabel.Text = (Get-Translation "completedSuccess")
        $statusLabel.ForeColor = [System.Drawing.Color]::DarkGreen
        [System.Windows.Forms.MessageBox]::Show(((Get-Translation "success")), "Success", "OK", "Information")
    }
    catch {
        $statusLabel.Text = ((Get-Translation "error")) + " " + $_.Exception.Message
        $statusLabel.ForeColor = [System.Drawing.Color]::Red
        [System.Windows.Forms.MessageBox]::Show(((Get-Translation "error")) + " " + $_.Exception.Message, "Error", "OK", "Error")
    }
    finally {
        # Re-enable UI
        $processBtn.Enabled = $true
        $browseFilesBtn.Enabled = $true
        $browseFolderBtn.Enabled = $true
        $removeBtn.Enabled = $true
        $clearBtn.Enabled = $true
        $langBtn.Enabled = $true
        $progressBar.Value = 0
    }
})

# If files passed via command line, add them to the list
if ($env:1) {
    $arg = ([regex]'"[^"]+"|[^ ]+').Matches($env:1)
    foreach ($a in $arg) {
        $path = $a.Value.Trim('"')
        if (Test-Path -LiteralPath $path) {
            $fileListBox.Items.Add($path)
        }
    }
    ResizeListBox
}

# Initialize language
Update-Language

# Show the form
$form.ShowDialog()

} ## .$Main

## Original processing function with GUI integration - MODIFIED
function ProcessFilesOriginal {
    param(
        [array]$choices,
        [string]$cryptoName = "bat2file",
        [string]$pathFolder = "%~dp0",
        [scriptblock]$progressCallback
    )
    
    & $progressCallback 25 "Initializing encoding parameters..."
    
    # Setup encoding parameters based on original logic
    $key = '.,;{-}[+](/)_|^=?O123456789ABCDeFGHyIdJKLMoN0PQRSTYUWXVZabcfghijklmnpqrstuvwxz!@#$&~E<*`%\>'; $chars = 91
    if ($choices -contains 'bat85') {
        $key = '.,;{-}[+](/)_|^=?O123456A789BCDEFGHYIeJKLMoN0PQRSTyUWXVZabcdfghijklmnpqrvstuwxz!@#$&~'; $chars = 85
    }
    
    $dict = ($key.ToCharArray()|sort -unique) -join ''; $randomized = 'default'
    
    # Randomize key if requested
    if ($choices -contains 'random' -and $choices -notcontains 'cabonly') {
        $base = $key.ToCharArray(); $rnd = new-object Random; $i = 0; $j = 0; $t = 0
        while ($i -lt $chars) {$t = $base[$i]; $j = $rnd.Next($i, $chars); $base[$i] = $base[$j]; $base[$j] = $t; $i++}
        $key = $base -join ''; $randomized = 'randomized'
    }
    
    # Password dialog if needed
    if ($choices -contains 'password' -and $choices -notcontains 'cabonly') {
        Add-Type -AssemblyName Microsoft.VisualBasic
        $inputKey = [Microsoft.VisualBasic.Interaction]::InputBox("Press enter to accept $randomized key:", "BAT$chars", $key)
        
        # Handle cancel button properly
        if ($inputKey -eq "") {
            # User pressed Cancel or left empty - use original key
            $key = $key
        } else {
            # Validate the input key
            if ($inputKey.Trim().Length -ne $chars -or (($inputKey.Trim().ToCharArray()|sort -unique) -join '') -ne $dict) {
                throw "Key must be $chars chars long with only non-repeating, shuffled characters from: $dict"
            }
            $key = $inputKey.Trim()
        }
    }
    
    & $progressCallback 35 "Setting up workspace..."
    
    # Start measuring total processing time
    $timer=new-object Diagnostics.StopWatch; $timer.Start()
    
    # Process command line arguments - supports multiple files and folders
    $arg = ([regex]'"[^"]+"|[^ ]+').Matches($env:1)
    
    # first input item must exist
    if (!(test-path -lit $($arg[0].Value.Trim('"')))) {
        throw "Path not found: " + $arg[0].Value.Trim('"')
    }
    
    $val = Get-Item -force -lit ($arg[0].Value.Trim('"'))
    $fn1 = $val.Name.replace('.','_')
    
    # Setup work and output dirs
    $root = Split-Path $val; $rng = [Guid]::NewGuid().Guid
    $dir = $root; $work = join-path $dir $rng; mkdir $work -ea 0 >''; new-item $($work + '~') -item File -ea 0 >''
    if (!(test-path -lit $work)) {$dir = [Environment]::GetFolderPath("Desktop");$work = join-path $dir $rng; mkdir $work -ea 0 >''}
    del $($work + '~') -force -ea 0 >''
    
    & $progressCallback 45 "Collecting target files..."
    
    # Grab target files names
    $files = @()
    foreach ($a in $arg) {
        $f = gi -force -lit $a.Value.Trim('"')
        if ($f.PSTypeNames -match 'FileInfo') {$files += $f} else {dir -lit $f -rec -force |? {!$_.PSIsContainer} |% {$files += $_}}
    }
    
    & $progressCallback 55 "Creating CAB archive..."
    
    # Jump to work dir
    push-location -lit $work
    
    # Create DDF file based on compression choice
    if ($choices -contains 'cpres') {
        $ddf1 = @"
.new Cabinet`r`n.Set Cabinet=ON`r`n.Set CabinetFileCountThreshold=0`r`n.Set ChecksumWidth=1`r`n.Set ClusterSize=CDROM
.Set LongSourceFileNames=ON`r`n.Set CompressionType=MSZip
.Set DiskDirectoryTemplate=`r`n.Set FolderFileCountThreshold=0`r`n.Set FolderSizeThreshold=0`r`n.Set GenerateInf=ON
.Set InfFileName=nul`r`n.Set MaxCabinetSize=0`r`n.Set MaxDiskFileCount=0`r`n.Set MaxDiskSize=0`r`n.Set MaxErrors=0
.Set ReservePerCabinetSize=0`r`n.Set ReservePerDataBlockSize=0`r`n.Set ReservePerFolderSize=0`r`n.Set RptFileName=nul
.Set UniqueFiles=ON`r`n.Set SourceDir=.`r`n
"@
    } else {
        $ddf1 = @"
.new Cabinet`r`n.Set Cabinet=ON`r`n.Set CabinetFileCountThreshold=0`r`n.Set ChecksumWidth=1`r`n.Set ClusterSize=CDROM
.Set LongSourceFileNames=ON`r`n.Set CompressionType=LZX`r`n.Set CompressionLevel=7`r`n.Set CompressionMemory=21
.Set DiskDirectoryTemplate=`r`n.Set FolderFileCountThreshold=0`r`n.Set FolderSizeThreshold=0`r`n.Set GenerateInf=ON
.Set InfFileName=nul`r`n.Set MaxCabinetSize=0`r`n.Set MaxDiskFileCount=0`r`n.Set MaxDiskSize=0`r`n.Set MaxErrors=0
.Set ReservePerCabinetSize=0`r`n.Set ReservePerDataBlockSize=0`r`n.Set ReservePerFolderSize=0`r`n.Set RptFileName=nul
.Set UniqueFiles=ON`r`n.Set SourceDir=.`r`n
"@
    }
    
    # MakeCab tool has issues with source filenames so just rename them while keeping destination full
    [int]$renamed = 100; $rel = $root.Length + 1; if ($rel -eq 4) {$rel--}
    foreach ($f in $files){
        try{ copy -lit $f.FullName -dest "$work\$renamed" -force -ea 0 >''}catch{}
        if (test-path -lit "$work\$renamed") {$ddf1 += $("$renamed `""+$f.FullName.substring($rel)+"`"`r`n")}
        $renamed++
    }
    [IO.File]::WriteAllText("$work\1.ddf", $ddf1, [Text.Encoding]::UTF8)
    
    # Determine compression setting
    if ($choices -contains 'nocompress') {$comp = 'OFF'} else {$comp = 'ON'}
    
    # Run MakeCab
    makecab.exe /F 1.ddf /D Compress=$comp /D CabinetNameTemplate=1.cab
    
    # Check if CAB was created
    if (!(test-path -lit "$work\1.cab")) {
        throw "Failed to create CAB archive"
    }
    
    # CAB only option
    if ($choices -contains 'cabonly') {
        $output = $dir + "\$fn1~.cab"
        & $progressCallback 90 "Saving CAB archive..."
        move -lit "$work\1.cab" -dest $output -force -ea 0
        push-location -lit $root; if (test-path -lit $work) {start -nonew -file cmd -args "/d/x/c rmdir /s/q ""$work"">nul 2>nul"}
        $timer.Stop()
        & $progressCallback 100 "CAB archive created: $output"
        return
    }
    
    & $progressCallback 70 "Generating text decoding header..."
    
    # MODIFIED HEADER with Russian support and directory creation
    $HEADER = "@echo off &chcp 65001 >nul`r`n"
    
    # External key file support - NEW
    if ($choices -contains 'extkey') {
        $keyFileName = "$fn1~.key"
        $HEADER += "if not exist `"%~dp0$keyFileName`" (`r`n"
        $HEADER += "  echo ERROR: Key file '$keyFileName' not found!`r`n"
        $HEADER += "  echo This file is required for decryption.`r`n"
        $HEADER += "  pause`r`n"
        $HEADER += "  exit /b 1`r`n"
        $HEADER += ")`r`n"
        $HEADER += "set /p EXTKEY=<`"%~dp0$keyFileName`"`r`n"
    }
    
    # Create directories if they don't exist - NEW
    $HEADER += "if not `"${pathFolder}`"==`"%~dp0`" (`r`n"
    $HEADER += "  if not exist `"${pathFolder}`" mkdir `"${pathFolder}`" 2>nul`r`n"
    $HEADER += ")`r`n"
    $HEADER += "pushd `"${pathFolder}`"`r`n"
    
    $HEADER += '@set "0=%~f0" &powershell -nop -c $f=[IO.File]::ReadAllText($env:0,[Text.Encoding]::UTF8)-split'':'
    $HEADER += "${cryptoName}"
    $HEADER += '\:.*'';iex($f[1]); X(1) '
    $HEADER += "&timeout /t 6 &exit/b`r`n`r`n:${cryptoName}: Compressed2TXT v6.5 (Modified)`r`n"
    
    # Line length
    if ($choices -contains 'longlines') {$line = 1016} else {$line = 128}
    
    # Password and external key handling - MODIFIED
    if ($choices -contains 'extkey') {
        $HEADER += '$k=$env:EXTKEY;if(!$k){exit};Add-Type -Ty @' + "'`r`n"
    } elseif ($choices -contains 'password') {
        $HEADER += '$b=''Microsoft.VisualBasic'';Add-Type -As $b;$k=iex "[$b.Interaction]::InputBox(''Key'','+$chars+')";'
        $HEADER += 'if($k.Length-ne'+$chars+'){exit};Add-Type -Ty @' + "'`r`n"
    } else {
        $HEADER += '$k='''+$key+"'; Add-Type -Ty @'`r`n"
    }
    
    # Generate decoding C# snippet with UTF-8 support - MODIFIED
    if ($choices -contains 'bat85') {
        $HEADER += @'
using System.IO;using System.Text; public class BAT85 {public static void Dec (ref string[] f, int x, string fo, string key) { unchecked {
byte[] b85=new byte[256];long n=0;int p=0,q=0,c=255,z=f[x].Length; while (c>0) b85[c--]=85; while (c<85) b85[key[c]]=(byte)c++;
int[] p85={52200625,614125,7225,85,1}; string dir=Path.GetDirectoryName(fo); if(!string.IsNullOrEmpty(dir)&&!Directory.Exists(dir))
Directory.CreateDirectory(dir); using (FileStream o=new FileStream(fo,FileMode.Create)) { for (int i=0;i != z;i++) {
c=b85[f[x][i]]; if (c==85) continue; n += c * p85[p++]; if (p==5) {p=0; q=4; while (q > 0) {q--; o.WriteByte((byte)(n>>8*q));}
n=0;}} if (p>0) {for (int i=0;i<5-p;i++) {n += 84 * p85[p+i];} q=4; while (q>(5-p)) {o.WriteByte((byte)(n>>8*(--q)));} } } }}}
'@ + "`r`n'@; " + '$env:__CD__=(Get-Location).Path; cd -Lit($env:__CD__); function X([int]$x=1){[BAT85]::Dec([ref]$f,$x+1,$x,$k); ' 
    } else {
        $HEADER += @'
using System.IO;using System.Text;public class BAT91{public static void Dec(ref string[] f,int x,string fo,string key){unchecked{int n=0,c=255,q=0
,v=91,z=f[x].Length; byte[]b91=new byte[256]; while(c>0) b91[c--]=91; while(c<91) b91[key[c]]=(byte)c++; string dir=Path.GetDirectoryName(fo);
if(!string.IsNullOrEmpty(dir)&&!Directory.Exists(dir)) Directory.CreateDirectory(dir); using (FileStream o=new
FileStream(fo,FileMode.Create)){for(int i=0;i!=z;i++){c=b91[f[x][i]]; if(c==91)continue; if(v==91){v=c;}else{v+=c*91;q|=v<<n;if(
(v&8191)>88){n+=13;}else{n+=14;}v=91;do{o.WriteByte((byte)q);q>>=8;n-=8;}while(n>7);}}if(v!=91)o.WriteByte((byte)(q|v<<n));} }}}
'@ + "`r`n'@; " + '$env:__CD__=(Get-Location).Path; cd -Lit($env:__CD__); function X([int]$x=1){[BAT91]::Dec([ref]$f,$x+1,$x,$k); '
    }
    
    # Generate expand function
    $HEADER += "expand -R `$x -F:* .; del `$x -force}`r`n`r`n:${cryptoName}:[ $fn1`r`n"
    
    & $progressCallback 80 "Encoding CAB to text..."
    
    # BAT91 or BAT85 ascii encoding the cab archive
    $output = $dir + "\$fn1~.bat"; $outputkey = $dir + "\$fn1~.key"
    [IO.File]::WriteAllText($output, $HEADER, [Text.Encoding]::UTF8)
    
    $enctimer=new-object Diagnostics.StopWatch; $enctimer.Start()
    if ($choices -contains 'bat85') {
        [BAT85]::Enc("$work\1.cab", $output, $key, $line)
    } else {
        [BAT91]::Enc("$work\1.cab", $output, $key, $line)
    }
    $enctimer.Stop()
    
    [IO.File]::AppendAllText($output, "`r`n:${cryptoName}:]`r`n", [Text.Encoding]::UTF8)
    
    & $progressCallback 95 "Finalizing..."
    
    # Save decoding key externally - MODIFIED for external key option
    if ($choices -contains 'extkey') {
        [IO.File]::WriteAllText($outputkey, $key, [Text.Encoding]::UTF8)
        & $progressCallback 98 "External key file created: $outputkey"
    } elseif ($choices -contains 'password') {
        [IO.File]::WriteAllText($outputkey, $key, [Text.Encoding]::UTF8)
    } else {
        del $outputkey -force -ea 0 >''
    }
    
    # Cleanup work dir
    push-location -lit $root; if (test-path -lit $work) {start -nonew -file cmd -args "/d/x/c rmdir /s/q ""$work"">nul 2>nul"}
    $timer.Stop()
    
    $outputMessage = "Done in $([math]::Round($timer.Elapsed.TotalSeconds,4)) sec - Output: $output"
    if ($choices -contains 'extkey') {
        $outputMessage += "`nKey file: $outputkey"
    }
    & $progressCallback 100 $outputMessage
}

## Text encoding classes (from original script) - MODIFIED with UTF-8 support
Add-Type -Ty @'
using System.IO;
using System.Text;
public class BAT85 {
  public static void Enc(string fi, string fo, string key, int line) {
    byte[] a = File.ReadAllBytes(fi), b85=new byte[85], q = new byte[5]; long n = 0; int p = 0,c = 0,v = 0,l = 0,z = a.Length;
    unchecked {
      while (c<85) {b85[c] = (byte)key[c++];}
      using (FileStream o = new FileStream(fo, FileMode.Append, FileAccess.Write, FileShare.Read, 4096, FileOptions.None)) {
        byte[] prefix = Encoding.UTF8.GetBytes("::");
        o.Write(prefix, 0, prefix.Length);
        for (int i = 0; i != z; i++) {
          c = a[i];
          if (p == 3) {
            n |= (byte)c; v = 5; while (v > 0) {v--; q[v] = b85[(byte)(n % 85)]; n /= 85;}
            o.Write(q, 0, 5); n = 0; p = 0; l += 5;
            if (l > line) {l = 0; byte[] newline = Encoding.UTF8.GetBytes("\r\n::"); o.Write(newline, 0, newline.Length);}
          } else {
            n |= (uint)(c << (24 - (p * 8))); p++;
          }
        }
        if (p > 0) {
          for (int i=p;i<3-p;i++) {n |= (uint)(0 << (24 - (p * 8)));}
          n |= 0; v = 5; while (v > 0) {v--; q[v] = b85[(byte)(n % 85)]; n /= 85;} o.Write(q, 0, p + 1);
        }
      }
    }
  }
  public static void Dec (ref string[] f, int x, string fo, string key) { unchecked {
    byte[] b85=new byte[256];long n=0;int p=0,q=0,c=255,z=f[x].Length; while (c>0) b85[c--]=85; while (c<85) b85[key[c]]=(byte)c++;
    int[] p85={52200625,614125,7225,85,1}; string dir=Path.GetDirectoryName(fo); if(!string.IsNullOrEmpty(dir)&&!Directory.Exists(dir))
    Directory.CreateDirectory(dir); using (FileStream o=new FileStream(fo,FileMode.Create)) { for (int i=0;i != z;i++) {
    c=b85[f[x][i]]; if (c==85) continue; n += c * p85[p++]; if (p==5) {p=0; q=4; while (q > 0) {q--; o.WriteByte((byte)(n>>8*q));}
    n=0;}} if (p>0) {for (int i=0;i<5-p;i++) {n += 84 * p85[p+i];} q=4; while (q>(5-p)) {o.WriteByte((byte)(n>>8*(--q)));} } } }}
}
public class BAT91 {
  public static void Enc(string fi, string fo, string key, int line) {
    byte[] a = File.ReadAllBytes(fi), b91 = new byte[91]; int n = 0, c = 0, v = 0, q = 0, l = 0, z = a.Length;
    while (c<91) {b91[c] = (byte)key[c++];}
    using (FileStream o = new FileStream(fo, FileMode.Append, FileAccess.Write, FileShare.Read, 4096, FileOptions.None)) {
      byte[] prefix = Encoding.UTF8.GetBytes("::");
      o.Write(prefix, 0, prefix.Length);
      for (int i = 0; i != z; i++) {
        q |= (byte)a[i] << n; n += 8;
        if (n > 13) {
          v = q & 8191; if (v > 88) {q >>= 13; n -= 13;} else {v = q & 16383; q >>= 14; n -= 14;}
          o.WriteByte(b91[v % 91]); o.WriteByte(b91[v / 91]);
          l += 2; if (l > line) {l = 0; byte[] newline = Encoding.UTF8.GetBytes("\r\n::"); o.Write(newline, 0, newline.Length);}
        }
      }
      if (n > 0) {o.WriteByte(b91[q % 91]); if (n > 7 || q > 90) {o.WriteByte(b91[q / 91]);}}
    }
  }
  public static void Dec(ref string[] f,int x,string fo,string key){unchecked{int n=0,c=255,q=0
  ,v=91,z=f[x].Length; byte[]b91=new byte[256]; while(c>0) b91[c--]=91; while(c<91) b91[key[c]]=(byte)c++; string dir=Path.GetDirectoryName(fo);
  if(!string.IsNullOrEmpty(dir)&&!Directory.Exists(dir)) Directory.CreateDirectory(dir); using (FileStream o=new
  FileStream(fo,FileMode.Create)){for(int i=0;i!=z;i++){c=b91[f[x][i]]; if(c==91)continue; if(v==91){v=c;}else{v+=c*91;q|=v<<n;if(
  (v&8191)>88){n+=13;}else{n+=14;}v=91;do{o.WriteByte((byte)q);q>>=8;n-=8;}while(n>7);}}if(v!=91)o.WriteByte((byte)(q|v<<n));} }}
}
'@

}; .$PS; .$Main
#-.-# hybrid script, can be pasted directly into powershell console