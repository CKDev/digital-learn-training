// Color formats MUI can parse: hex (#rgb, #rgba, #rrggbb, #rrggbbaa) and
// rgb()/rgba()/hsl()/hsla(). Keep in sync with Organization::COLOR_REGEX.
const COLOR_REGEX =
  /^(#([0-9a-f]{3,4}|[0-9a-f]{6}|[0-9a-f]{8})|(rgba?|hsla?)\(\s*[\d.]+%?(\s*[,\s/]\s*[\d.]+%?){2,3}\s*\))$/i;

export const COLOR_FORMAT_HINT = "Enter a hex, rgb(a), or hsl(a) color, e.g. #01579B or rgba(0, 0, 0, 0.56).";

export function isValidColor(value) {
  return typeof value === "string" && COLOR_REGEX.test(value.trim());
}

// Deep-merges stored palette overrides onto the defaults, dropping any color
// that isn't valid so a bad value can't break theme creation.
export function sanitizePalette(defaults, overrides) {
  if (!overrides || typeof overrides !== "object") return defaults;

  const result = { ...defaults };
  Object.entries(overrides).forEach(([key, value]) => {
    if (value && typeof value === "object") {
      result[key] = sanitizePalette(defaults[key] || {}, value);
    } else if (isValidColor(value)) {
      result[key] = value;
    } else {
      console.error(`Ignoring invalid theme color for "${key}":`, value);
    }
  });
  return result;
}
