import json
import glob

keys = {
  "home_yieldSummarySameSign": "[NEEDS_NATIVE_REVIEW] Your predicted yield is {percent}% due to {factor1} and {factor2}",
  "home_yieldSummaryOppositeSign": "[NEEDS_NATIVE_REVIEW] Your predicted yield is {percent}% — {factor1} is helping, but {factor2} is pulling it down",
  "factor_soilMoisture": "[NEEDS_NATIVE_REVIEW] Soil Moisture",
  "factor_pestRisk": "[NEEDS_NATIVE_REVIEW] Pest Risk",
  "factor_rainfall": "[NEEDS_NATIVE_REVIEW] Rainfall"
}

for file in glob.glob("lib/l10n/*.arb"):
    if file == "lib/l10n/app_en.arb":
        continue
    with open(file, 'r', encoding='utf-8') as f:
        data = json.load(f)
    for k, v in keys.items():
        data[k] = v
    with open(file, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
