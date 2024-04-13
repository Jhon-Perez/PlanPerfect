# ChatGPT produces code with a lot of new line characters and whitespace, so remove any unneccessary characters.
# even if it is in the middle of the string
def clean_string(string: str) -> str:
    return string.replace("\n", "").replace("  ", "")