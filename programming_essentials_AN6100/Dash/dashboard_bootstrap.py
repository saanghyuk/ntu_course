import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output
import plotly.graph_objs as go
import pandas as pd

# Import bootstrap for Layout of the board
import dash_bootstrap_components as dbc
# BS = "https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
app = dash.Dash(external_stylesheets=[dbc.themes.COSMO])


df = pd.read_csv('WebAssignment.csv')

features = ['ProductID', 'Quantity', 'Amount', 'Cost']
years = df['YYYY'].unique()
print(years)

app.layout = html.Div([
        html.Div([
            dbc.Row(
                dbc.Col(
                    dbc.Alert(
                        children=[
                        html.H3("Please Choose the DATA and PERIODS", className="alert-heading", style={'textAlign': 'center'}),
                        html.Hr(),
                        html.P(
                            children=[
                                "ProductID : Average Number of Product Types per Customer ",
                                html.Br(),
                                "Quantity : Average Quantity per Customer ",
                                html.Br(),
                                "Cost : Average Cost per Customer",
                                html.Br(),
                                "Amount : Average Amount per Customer ",
                                html.Br(),
                                html.Br(),
                                html.Pre(
                                [
                                    "Noel Sanghyuk Son",
                                    html.Br(),
                                    "Jul, 2021"

                                ])
                            ]
                        , style={'textAlign': 'center'})

                        ]

                    ),
                    width={"size": 6}
                ), justify="center"
            ),
            dbc.Row(
                dbc.Col(
                dcc.Dropdown(
                    id='yaxis',
                    options=[{'label': i.title(), 'value': i} for i in features],
                    value='Amount'
                )
              , width={"size": 3})
            , justify="center"),
            dbc.Row(
                html.P()
            ),
            dbc.Row(
                children = [
                dbc.Col(
                    children=[
                    dbc.Badge("Start Year", className="ml-1"),
                    dcc.Dropdown(
                        id='start_year',
                        options=[{'label': i, 'value': i} for i in years],
                        value=years[0]
                    )
                    ]
                    , width={"size": 2}
                ),
                dbc.Col(
                    children=[
                        dbc.Badge("End Year", className="ml-1"),
                        dcc.Dropdown(
                        id='end_year',
                        options=[{'label': i, 'value': i} for i in years],
                        value=years[-1]
                )]
                 , width={"size": 2})
                ]
            , justify="center")
        ]),
        html.Div([
        dbc.Row(
            [dbc.Col(dcc.Graph(id='feature-graphic'), style={"height": "100%", "background-color": "green"},)])
        ])
], style={"height" : "100%"})


@app.callback(
    Output('end_year', 'options'),
    Input('start_year', 'value'))
def update_end_year(startyear):
    return [{'label': year, 'value': year} for year in years if year >= startyear]

@app.callback(
    Output('start_year', 'options'),
    Input('end_year', 'value')
    )
def update_start_year(endyear):
    print(endyear)
    return [{'label': year, 'value': year} for year in years if year <= endyear]




@app.callback(
    Output('feature-graphic', 'figure'),
    [Input('yaxis', 'value'),
     Input('start_year', 'value'),
     Input('end_year', 'value')
     ])
def update_graph(yaxis_name, startyear, endyear):
    yearly_records = []
    for i in range(startyear, endyear+1):
        each_year_df=df[df['YYYY'] == i]
        count_of_unique_customers = len(each_year_df['CustomerID'].unique())
        sum_value = each_year_df[yaxis_name].sum()
        cal = sum_value/count_of_unique_customers
        yearly_records.append(cal)
    print(yearly_records)
    return {
        'data': [go.Scatter(
            x=[year for year in range(startyear, endyear+1)],
            y=yearly_records,
            # text="Line Chart, Per Unique Customer",
            mode='lines',
            marker={
                'size': 20,
                'opacity': 0.9,
                'line': {'width': 0.5, 'color': 'white'}
            }
        )],
        'layout': go.Layout(
            title = "{} Per Unique Customer in {} ~ {} ".format(yaxis_name, startyear, endyear),
            xaxis={'title': "Yearly Records"},
            yaxis={'title': yaxis_name},
            # margin={'l': 40, 'b': 40, 't': 10, 'r': 0},
            hovermode='closest',
            height = 700,
        )
    }

if __name__ == '__main__':
    app.run_server()
