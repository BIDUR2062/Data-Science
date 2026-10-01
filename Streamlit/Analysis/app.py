import streamlit as st
import pandas as pd
import plotly.express as px

# Page Configuration
st.set_page_config(
    page_title="Pizza Sales Dashboard", layout="wide", page_icon=":pizza:"
)

# Import Data
df = pd.read_csv("pizza_sales.csv")

# Create sidebar
st.sidebar.header("Filter data here")

pizza_size = st.sidebar.multiselect(
    "Select Data", options=df["pizza_size"].unique(), default=df["pizza_size"].unique()
)

df_selection = df.query("pizza_size ==  @pizza_size")


# Dashboard
st.header("Pizza Sales Dashboard")
st.subheader(":chart_with_upwards_trend: KPI")

# Calculation of KPIs
total_revenue = df_selection["total_price"].sum()
total_pizza_sold = df_selection["quantity"].sum()
total_orders = df_selection["order_id"].nunique()
average_order_value = total_revenue / total_orders
average_pizza_per_order = total_pizza_sold / total_orders

kpi1, kpi2, kpi3, kpi4, kpi5 = st.columns(5)

with kpi1:
    st.write("Total Revenue")
    st.write(f"${total_revenue:,.2f}")
    # st.metric(label='Total Revenue',value=f'${total_revenue:,.2f}')

with kpi2:
    st.write("Total Pizza sold")
    st.write(f"{total_pizza_sold}")

with kpi3:
    st.write("Total Orders")
    st.write(f"{total_orders}")

with kpi4:
    st.write("Average Order Value")
    st.write(f"{average_order_value:,.2f}")

with kpi5:
    st.write("Average pizza per order")
    st.write(f"{average_pizza_per_order:,.2f}")

# BarChart

category_quantity = (
    df_selection.groupby("pizza_category")["quantity"]
    .sum()
    .reset_index()
)

fig = px.bar(
    category_quantity,
    x="pizza_category",
    y="quantity",
    title="Total Pizza Sold by Pizza Category",
    labels={'pizza_category': 'Pizza Category',
            'quantity':'Quantity'}
)

st.plotly_chart(fig)