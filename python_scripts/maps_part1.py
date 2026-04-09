# using plotly to create maps in python
##################
# Sof Antelo
# Comp Bio 6100
# 4/7/2026

#load packages:
from bokeh.palettes import viridis
import json 
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go

#loading data 
gap = px.data.gapminder().query("year==2007")
gap.head()

#minimal level choropleth
fig = px.choropleth(
    gap,
    locations = "iso_alpha",
    color = "lifeExp",
    hover_name = "country",
    color_continuous_scale = "viridis",
    title = "Life Exp. By Country (2007)"
)
fig.show()

#crop this and improve labels:
fig.update_layout(
    coloraxis_colorbar_title = "Years",
    margin = dict(l=0, r=0, t=50, b=0)
)

# gdp with more hovering info
fig = px.choropleth(
    gap,
    locations = "iso_alpha",
    color = "gdpPercap",
    hover_name = "country",
    hover_data = {
        "lifeExp": ":1f",
        "pop": ":",
        "gdpPercap": ":,.0f",
        "iso_alpha": False
    },
    color_continuous_scale="Plasma",
    title= "GDP per cap. by country (2007)"
)
fig.show()

# update outlines of GDP map
fig.update_geos(
    showframe = False,
    showcoastlines = False
)

#crop into one region 
americas = gap.query("continent == 'Americas'")

fig = px.choropleth(
    americas,
    locations = "iso_alpha",
    color = "lifeExp",
    hover_name = "country",
    color_continuous_scale = "Tealgrn",
    title = "Life Exp. By Country (2007)"
)

fig.update_geos(
    scope = "north america",
    showland = True,
    landcolor = "rgb(240,240,240)"
)

fig.show()

#a projection is a mathematical models good for displaying a round thing on a flat circle

fig.update_geos(projection_type="natural earth")
fig.update_geos(projection_type="orthographic")

# more projection things 
from urllib.request import urlopen

with urlopen("https://raw.githubusercontent.com/plotly/datasets/master/geojson-counties-fips.json") as response:
    county_geojson = json.load(response)

county_df = pd.read_csv(
    "https://raw.githubusercontent.com/plotly/datasets/master/fips-unemp-16.csv",
    dtype={"fips": str}
)

county_df.head()

#country choropleth for counties 
fig = px.choropleth_map(
    county_df,
    geojson=county_geojson,
    locations="fips",
    featureidkey="id",
    color="unemp",
    color_continuous_scale="Viridis",
    zoom=3,
    center={"lat": 37.8, "lon": -96},
    map_style="carto-positron",
    opacity=0.7,
    title="US county unemployment"
)
fig.show()

#modifying the style and zoom 
fig.update_layout(
    map_style="open-street-map",
    margin=dict(l=0, r=0, t=50, b=0)
)
fig.show()
#improve polygon borders 
fig.update_traces(marker_line_width=0.2)
fig.show()

# dark theme 
fig.update_layout(map_style="carto-darkmatter")
fig.show()


# 4/9/26
#Density heat maps
eq = pd.read_csv(
    "https://raw.githubusercontent.com/plotly/datasets/master/earthquakes-23k.csv"
)
eq.head()

fig = px.density_map(
    eq,
    lat = "Latitude", 
    lon = "Longitude",
    z = "Magnitude", #Z is the variable we are actually looking for
    radius = 10,
    zoom = 0,
    center = {"lat": 0, "lon": 180},
    map_style = "open-street-map", 
    title = "Global Earthquake Density"
)

fig.show()

fig = px.density_map(
    eq,
    lat = "Latitude", 
    lon = "Longitude",
    z = "Magnitude", #Z is the variable we are actually looking for
    radius = 10, #setting higer radius gives more fidelity
    zoom = 0,
    center = {"lat": 0, "lon": 180},
    map_style = "open-street-map", 
    title = "Global Earthquake Density"
)
fig.update_traces(opacity = 0.5)

#focus on region 
pacific = eq.query("Latitude > -60 and Latitude < 60 and Longitude > 100")

fig = px.density_map(
    pacific,
    lat = "Latitude", 
    lon = "Longitude",
    z = "Magnitude", #Z is the variable we are actually looking for
    radius = 10, #setting higer radius gives more fidelity
    zoom = 0,
    center = {"lat": 0, "lon": 180},
    map_style = "carto-darkmatter", 
    title = "Global Earthquake Density"
)
fig.show()
fig.update_traces(opacity = 0.5)

#bubble map 
gap
fig = px.scatter_geo(
    gap,
    locations = "iso_alpha",
    color = "continent",
    hover_name = "country",
    size = "pop",
    projection = "natural earth"
)
fig.show()

df = px.data.gapminder()

fig = px.scatter_geo(
    df,
    locations = "iso_alpha",
    color = "continent",
    hover_name = "country",
    size = "pop",
    animation_frame = "year",
    projection = "natural earth"
)
fig.show()

from dash import Dash, dcc, html
#keeps current fig

app = Dash() #initiating an app
#specifically making an html web app
app.layout = html.Div([
    dcc.Graph(figure=fig)
    ]) 
#not using a server, just doing it locally
app.run(debug = True, use_reloader = False)