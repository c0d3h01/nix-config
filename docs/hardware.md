# My Hardware

```bash
System:
  Host: nixos Kernel: 6.16.0 arch: x86_64 bits: 64
  Desktop: GNOME v: 48.3 Distro: NixOS 25.11 (Xantusia)
Machine:
  Type: Laptop System: Dell product: Inspiron 3505 v: 1.30.0
    serial: <superuser required>
  Mobo: Dell model: 05772N v: A01 serial: <superuser required> UEFI: Dell
    v: 1.30.0 date: 03/10/2025
Battery:
  ID-1: BAT1 charge: 32.5 Wh (100.0%) condition: 32.5/42.0 Wh (77.4%)
CPU:
  Info: quad core model: AMD Ryzen 5 3500U with Radeon Vega Mobile Gfx
    bits: 64 type: MT MCP cache: L2: 2 MiB
  Speed (MHz): avg: 2770 min/max: 1400/2100 cores: 1: 2770 2: 2770 3: 2770
    4: 2770 5: 2770 6: 2770 7: 2770 8: 2770
Graphics:
  Device-1: Advanced Micro Devices [AMD/ATI] Picasso/Raven 2 [Radeon Vega
    Series / Radeon Mobile Series] driver: amdgpu v: kernel
  Device-2: Sunplus Innovation Integrated_Webcam_HD driver: uvcvideo
    type: USB
  Display: wayland server: X.org v: 1.21.1.18 compositor: gnome-shell
    driver: gpu: amdgpu resolution: 1920x1080~60Hz
  API: EGL v: 1.5 drivers: kms_swrast,radeonsi,swrast
    platforms: gbm,wayland,x11,surfaceless,device
  API: OpenGL v: 4.6 compat-v: 4.5 vendor: amd mesa v: 25.2.0 renderer: AMD
    Radeon Vega 8 Graphics (radeonsi raven ACO DRM 3.64 6.16.0)
  API: Vulkan v: 1.4.313 drivers: radv,llvmpipe surfaces: N/A
  Info: Tools: api: clinfo, eglinfo, glxinfo, vulkaninfo x11: xprop,xrandr
Audio:
  Device-1: Advanced Micro Devices [AMD/ATI] Raven/Raven2/Fenghuang HDMI/DP
    Audio driver: snd_hda_intel
  Device-2: Advanced Micro Devices [AMD] Audio Coprocessor
    driver: snd_pci_acp3x
  Device-3: Advanced Micro Devices [AMD] Family 17h/19h/1ah HD Audio
    driver: snd_hda_intel
  API: ALSA v: k6.16.0 status: kernel-api
  Server-1: PipeWire v: 1.4.6 status: active
Network:
  Device-1: Realtek RTL810xE PCI Express Fast Ethernet driver: r8169
  IF: enp2s0 state: down mac: 60:18:95:66:02:a8
  Device-2: Realtek RTL8821CE 802.11ac PCIe Wireless Network Adapter
    driver: rtw88_8821ce
  IF: wlp3s0 state: up mac: 72:94:25:a8:ac:4b
Bluetooth:
  Device-1: Realtek Bluetooth Radio driver: btusb type: USB
  Report: hciconfig ID: hci0 state: up address: C8:94:02:12:43:BA bt-v: 4.2
Drives:
  Local Storage: total: 1.14 TiB used: 44.99 GiB (3.8%)
  ID-1: /dev/nvme0n1 vendor: KDI model: OM3PDP3-AD NVMe 256GB
    size: 238.47 GiB
  ID-2: /dev/sda vendor: Seagate model: ST1000LM035-1RK172 size: 931.51 GiB
Partition:
  ID-1: / size: 225.47 GiB used: 44.89 GiB (19.9%) fs: btrfs
    dev: /dev/nixos-root
  ID-2: /boot size: 1022 MiB used: 106.3 MiB (10.4%) fs: vfat
    dev: /dev/nvme0n1p1
  ID-3: /home size: 225.47 GiB used: 44.89 GiB (19.9%) fs: btrfs
    dev: /dev/nixos-root
  ID-4: /var/log size: 225.47 GiB used: 44.89 GiB (19.9%) fs: btrfs
    dev: /dev/nixos-root
  ID-5: /var/tmp size: 225.47 GiB used: 44.89 GiB (19.9%) fs: btrfs
    dev: /dev/nixos-root
Swap:
  ID-1: swap-1 type: zram size: 5.68 GiB used: 1.15 GiB (20.3%)
    dev: /dev/zram0
  ID-2: swap-2 type: partition size: 12 GiB used: 0 KiB (0.0%)
    dev: /dev/nvme0n1p2
Sensors:
  Src: /sys System Temperatures: cpu: 59.0 C mobo: 52.0 C sodimm: 47.0 C
    gpu: amdgpu temp: 59.0 C
  Fan Speeds (rpm): fan-1: 3600
Info:
  Memory: total: 6 GiB available: 5.68 GiB used: 3.58 GiB (63.0%)
  Processes: 357 Uptime: 0h 28m Shell: Zsh inxi: 3.3.38
```
