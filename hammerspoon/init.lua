local TARGET_DEVICE_NAME = "TOZO NC9 Pro"
local TARGET_INPUT_VOLUME = 100
local VOLUME_TOLERANCE = 0.5
local DEBOUNCE_SECONDS = 1

local AudioEvent = {
  DEVICE_LIST_CHANGED = "dev#",
  DEFAULT_INPUT_CHANGED = "dIn ",
}

local debounceTimer = nil

local function enforceInputVolume()
  local device = hs.audiodevice.defaultInputDevice()
  if not device then
    hs.printf("[mic-volume] no default input device")
    return
  end

  local name = device:name()
  if name ~= TARGET_DEVICE_NAME then
    hs.printf("[mic-volume] default input is %q, skipping", name)
    return
  end

  local volume = device:inputVolume()
  if volume == nil then
    hs.printf("[mic-volume] %q does not report an input volume", name)
  elseif math.abs(volume - TARGET_INPUT_VOLUME) < VOLUME_TOLERANCE then
    hs.printf("[mic-volume] %q already at %.1f", name, volume)
  elseif device:setInputVolume(TARGET_INPUT_VOLUME) then
    hs.printf("[mic-volume] %q input volume %.1f -> %d", name, volume, TARGET_INPUT_VOLUME)
  else
    hs.printf("[mic-volume] failed to set input volume on %q", name)
  end
end

local function scheduleEnforce()
  if debounceTimer then
    debounceTimer:stop()
  end
  debounceTimer = hs.timer.doAfter(DEBOUNCE_SECONDS, enforceInputVolume)
end

hs.audiodevice.watcher.setCallback(function(event)
  if event == AudioEvent.DEVICE_LIST_CHANGED or event == AudioEvent.DEFAULT_INPUT_CHANGED then
    scheduleEnforce()
  end
end)
hs.audiodevice.watcher.start()

scheduleEnforce()
