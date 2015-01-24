function lambda_prompt_filter()
    clink.prompt.value = string.gsub(clink.prompt.value, "{lamb}", "λ")
end

print("testing")

clink.prompt.register_filter(lambda_prompt_filter, 40)