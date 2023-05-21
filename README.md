# SensorViewer

Software for recording measurements made by sensors

<p align="center">
<img src="/image/SensorViewer_Screenshot.png" width="500">
</p>

# Version

1.0

# Release date

2021-03-18

# DOI

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7955166.svg)](https://doi.org/10.5281/zenodo.7955166)

# Description

Displays on the screen values of magnitudes measured and sent to the RS232 serial port of a computer  

# Configuration files

- serialport.json
> JSON file for the configuration of the connection to the RS232 port
- sensorviewer.json
> JSON file for the configuration of the sensor value records
- parameters.json
> JSON file for the configuration of the magnitudes and units of measurement that will be displayed

# Configuration example

1- **serialport.json**

Example configuration in MacOS

```json
{
    "SerialPort": "/dev/cu.usbserial-1470",
    "BaudRate": 9600,
    "DataBits": 8,
    "StopBits": 1,
    "Parity": "N"
}     
```

2- **sensorviewer.json**

```json
{
    "Reading_Frequency": 5000,
    "Field_Separator": ";",
    "Dumpfile": 1,
    "Finlename": "dumpfile.txt",
    "AddDateAndTime": 1
}
```

3- **parameters.json**

```json
[
    {
        "parameter":"TDS",
        "unit":"ppm"
    },
    {
        "parameter":"Temperature",
        "unit":"°C"
    },
    {
        "parameter":"Conductivity",
        "unit":"mS/cm"
    },
    {
        "parameter":"Salinity",
        "unit":"PSU"
    },
    {
        "parameter":"Depth",
        "unit":"m"
    },
    {
        "parameter":"pH",
        "unit":""
    }
] 
```
