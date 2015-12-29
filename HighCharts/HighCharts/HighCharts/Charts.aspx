<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Charts.aspx.cs" Inherits="HighCharts.Charts" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <script src="Scripts/jquery-latest.js" type="text/javascript"></script>
    <script src="Scripts/highcharts.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            display();
            function display() {
                Highcharts.setOptions({
                    colors: ['#FFC62D', '#EA509B', '#01A4DA', '#C2D837', '#1C267D', '#43A743']
                });
                var chart = new Highcharts.Chart({

                    chart: {
                        renderTo: 'container',
                        type: 'column'
                    },
                    credits: {
                        enabled: false
                    },
                    yAxis: { title: { text: null} },

                    xAxis: {
                        labels: { enabled: false }, tickWidth: 0, title: { margin: 60 }
                    },
                    title: {
                        text:'Main Title'
                    },
                    subtitle: {
                        text: 'Main Subtitle'
                    },
                    plotOptions: {
                        chart: {
                            size: '100%'
                        },
                        series: {
                            groupPadding: 0,
                            cursor: 'pointer',
                            point: {
                                events: {
                                    click: function () {
                                        var drilldown = this.drilldown;
                                        drillDisplay(drilldown.categories, drilldown.data, drilldown.name, drilldown.color);
                                    }
                                }
                            }
                        }
                    },
                    legend: {
                        layout: 'vertical',
                        floating: false,
                        align: 'left',
                        verticalAlign: 'middle',
                        x: 60,
                        y: 1,
                        shadow: true,
                        border: 0,
                        borderRadius: 0,
                        borderWidth: 0, itemStyle: {
                            fontWeight: 'normal',
                            fontSize: '20px'
                        }
                    },
                    series: [
                    {
                        name: 'Criminal Law',
                        data: [{
                            y: 40,
                            drilldown: {
                                name: ['MSIE 6.0', 'MSIE 7.0', 'MSIE 8.0', 'MSIE 9.0'],
                                categories: ['MSIE 6.0', 'MSIE 7.0', 'MSIE 8.0', 'MSIE 9.0'],
                                data: [10.85, 7.35, 33.06, 2.81],
                                color: '#FFC62D'
                            }
                        }]

                    },

                    {
                        name: 'Criminal Procedure',
                        data: [{
                            y: 50, drilldown: {
                                name: ['MSIE 6.0', 'MSIE 7.0', 'MSIE 8.0', 'MSIE 9.0'],
                                categories: ['MSIE 6.0', 'MSIE 7.0', 'MSIE 8.0', 'MSIE 9.0'],
                                data: [50, 80, 20, 10],
                                color: '#EA509B'
                            }
                        }]


                    },

                    {
                        name: 'Contracts',
                        data: [{
                            y: 82, drilldown: {
                                name: ['MSIE 6.0', 'MSIE 7.0', 'MSIE 8.0', 'MSIE 9.0'],
                                categories: ['MSIE 6.0', 'MSIE 7.0', 'MSIE 8.0', 'MSIE 9.0'],
                                data: [5, 50, 30, 60],
                                color: '#01A4DA'
                            }
                        }]

                    },

                    {
                        name: 'Real Property',
                        data: [{
                            y: 60, drilldown: {
                                name: ['MSIE 6.0', 'MSIE 7.0', 'MSIE 8.0', 'MSIE 9.0'],
                                categories: ['MSIE 6.0', 'MSIE 7.0', 'MSIE 8.0', 'MSIE 9.0'],
                                data: [50, 30, 10, 50],
                                color: '#C2D837'
                            }
                        }]
                    },
                {
                    name: 'Torts',
                    data: [{
                        y: 80, drilldown: {
                            name: ['MSIE 6.0', 'MSIE 7.0', 'MSIE 8.0', 'MSIE 9.0'],
                            categories: ['MSIE 6.0', 'MSIE 7.0', 'MSIE 8.0', 'MSIE 9.0'],
                            data: [10.85, 7.35, 33.06, 2.81],
                            color: '#1C267D'
                        }
                    }]
                },
                    {
                        name: 'Evidence',
                        data: [{
                            y: 64, drilldown: {
                                name: ['MSIE 6.0', 'MSIE 7.0', 'MSIE 8.0', 'MSIE 9.0'],
                                categories: ['MSIE 6.0', 'MSIE 7.0', 'MSIE 8.0', 'MSIE 9.0'],
                                data: [10.85, 7.35, 33.06, 2.81],
                                color: '#43A743'
                            }
                        }]
                    }


                ]

                });
            }

            function drillDisplay(categories, data, name, color) {
                var newdata = generateDrillDownSeries(data, categories, color);
                var newchart = new Highcharts.Chart({
                    chart: {
                        renderTo: 'container',
                        type: 'column'
                    },
                    credits: {
                        enabled: false
                    },
                    yAxis: { title: { text: null} },
                    subtitle: {
                        text: 'Drill down Subtitle'
                    },

                    xAxis: {
                        labels: { enabled: false },
                        tickWidth: 0,
                        title: { margin: 60 }
                    },
                    plotOptions: {
                        chart: {
                            size: '100%'
                        },
                        series: {
                            groupPadding: 0,
                            cursor: 'pointer',
                            point: {
                                events: {
                                    click: function () {
                                        display();
                                    }
                                }
                            }
                        }
                    },
                    legend: {
                        layout: 'vertical',
                        floating: false,
                        align: 'left',
                        verticalAlign: 'middle',
                        x: 60,
                        y: 1,
                        shadow: false,
                        border: 0,
                        borderRadius: 0,
                        borderWidth: 0,
                        itemStyle: {
                            fontWeight: 'normal',
                            fontSize: '20px'
                        }
                    },
                    series: newdata
                });
            }

            function generateDrillDownSeries(data1, series, color) {
                var localdata = [];
                for (var i = 0; i < data1.length; i++) {
                    localdata.push({
                        "name": series[i],
                        "data": [{
                            "y": data1[i]
                        }],
                        "color": color
                    });
                }
                return localdata;
            }
        });

        

    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width: 905px; height: 400px" align="right" id="container">
    </div>
    </form>
</body>
</html>
