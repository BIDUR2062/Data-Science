import streamlit as st
from model import gemini

st.header("Gemini Integration LLM")

st.subheader("Version 3.8 Flash")

prompt = st.text_area(
    "Enter your prompt",
    placeholder="Explain about animal."
)

btn = st.button("Send Prompt ✈️")

if btn:
    if prompt.strip() == "":
        st.warning("Text field cannot be empty.")
    else:
        with st.spinner("Generating Content..."):
            answer = gemini(prompt)
            st.write(answer)
            st.toast("Content Generated.")
