# 添加日志输出，明确执行阶段
Write-Host "=== 开始关闭防火墙 ==="
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Write-Host "=== 防火墙关闭完成 ==="

Write-Host "=== 开始下载并安装 Chrome Remote Desktop 主机程序 ==="
& {
    $P = $env:TEMP + '\chromeremotedesktophost.msi'
    Write-Host "下载地址: https://dl.google.com/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi"
    Write-Host "保存路径: $P"
    Invoke-WebRequest 'https://dl.google.com/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi' -OutFile $P
    Write-Host "下载完成，开始安装..."
    Start-Process $P -Wait
    Remove-Item $P
    Write-Host "Chrome Remote Desktop 安装完成"
}

Write-Host "=== 开始下载并安装 Chrome 浏览器 ==="
& {
    $P = $env:TEMP + '\chrome_installer.exe'
    Write-Host "下载地址: https://dl.google.com/chrome/install/latest/chrome_installer.exe"
    Write-Host "保存路径: $P"
    Invoke-WebRequest 'https://dl.google.com/chrome/install/latest/chrome_installer.exe' -OutFile $P
    Write-Host "下载完成，开始安装..."
    Start-Process -FilePath $P -Args '/install' -Verb RunAs -Wait
    Remove-Item $P
    Write-Host "Chrome 安装完成"
}
