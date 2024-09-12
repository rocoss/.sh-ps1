# ����������� ����������� ������
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ������� ��� ��������� ���������� ����� �� min �� max
function Get-RandomNumber {
    param (
        [int]$min,
        [int]$max
    )
    return Get-Random -Minimum $min -Maximum ($max + 1)
}

# ������� ��� �������� ����������� ������� �� ������
function Move-CursorStraight {
    param (
        [int]$startX,
        [int]$startY,
        [int]$endX,
        [int]$endY,
        [int]$steps
    )

    $stepX = ($endX - $startX) / $steps
    $stepY = ($endY - $startY) / $steps

    for ($i = 0; $i -lt $steps; $i++) {  # �������� �� -lt ��� ����������� ����������
        $currentX = [Math]::Round($startX + $stepX * $i)
        $currentY = [Math]::Round($startY + $stepY * $i)
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($currentX, $currentY)
        Start-Sleep -Milliseconds (Get-RandomNumber -min 5 -max 20)
    }
}

# ������� ��� �������� �������������� ����������� �������
function Move-CursorWavy {
    param (
        [int]$startX,
        [int]$startY,
        [int]$endX,
        [int]$endY,
        [int]$steps,
        [double]$waveAmplitude
    )

    $stepX = ($endX - $startX) / $steps
    $stepY = ($endY - $startY) / $steps

    for ($i = 0; $i -lt $steps; $i++) {  # �������� �� -lt ��� ����������� ����������
        $currentX = [Math]::Round($startX + $stepX * $i)
        $currentY = [Math]::Round($startY + $stepY * $i + [Math]::Sin($i * [Math]::PI / 10) * $waveAmplitude)
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($currentX, $currentY)
        Start-Sleep -Milliseconds (Get-RandomNumber -min 5 -max 20)
    }
}

# ������� ��� ����������� ������� � ������� ����������
function Move-CursorWithTurns {
    param (
        [int]$startX,
        [int]$startY,
        [int]$endX,
        [int]$endY,
        [int]$steps
    )

    $stepX = ($endX - $startX) / $steps
    $stepY = ($endY - $startY) / $steps

    for ($i = 0; $i -lt $steps; $i++) {  # �������� �� -lt ��� ����������� ����������
        $currentX = [Math]::Round($startX + $stepX * $i)
        $currentY = [Math]::Round($startY + $stepY * $i + (Get-RandomNumber -min -10 -max 10)) # ��������� ����������
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($currentX, $currentY)
        Start-Sleep -Milliseconds (Get-RandomNumber -min 5 -max 20)
    }
}

# �������� ����� �������
while ($true) {
    # ���������� ��������� ���������� ��� ������ � �����
    $startX = [System.Windows.Forms.Cursor]::Position.X
    $startY = [System.Windows.Forms.Cursor]::Position.Y
    $endX = Get-RandomNumber -min 0 -max 1920
    $endY = Get-RandomNumber -min 0 -max 1080

    # ���������� ��������� ���������� ����� ��� �����������
    $steps = Get-RandomNumber -min 30 -max 100

    # �������� ��������� ��� ��������
    $movementType = Get-RandomNumber -min 1 -max 3

    switch ($movementType) {
        1 { Move-CursorStraight -startX $startX -startY $startY -endX $endX -endY $endY -steps $steps }
        2 { Move-CursorWavy -startX $startX -startY $startY -endX $endX -endY $endY -steps $steps -waveAmplitude 10 }
        3 { Move-CursorWithTurns -startX $startX -startY $startY -endX $endX -endY $endY -steps $steps }
    }

    # ���� ����� ���������� ��������� ����� ����� ��������� ���������
    Start-Sleep -Milliseconds (Get-RandomNumber -min 2000 -max 5000)
}