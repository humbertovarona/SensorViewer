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

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7955233.svg)](https://doi.org/10.5281/zenodo.7955233)

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

Example configuration in MacOS: 

> This software can be tested by loading in an Arduino UNO the file ***/src/RandomData_Generator.ino***, the configuration files corresponding to this example are in ***/src/configfiles***.

1. **serialport.json**

```json
{
    "SerialPort": "/dev/cu.usbserial-1470",
    "BaudRate": 9600,
    "DataBits": 8,
    "StopBits": 1,
    "Parity": "N"
}     
```

2. **sensorviewer.json**

```json
{
    "Reading_Frequency": 5000,
    "Field_Separator": ";",
    "Dumpfile": 1,
    "Filename": "dumpfile.txt",
    "AddDateAndTime": 1
}
```
> **Parameterization**
>> ***Reading_Frequency***
>>> Frequency in milliseconds for saving data to file.

>> ***Field_Separator***
>>> Data separator.

>> ***Dumpfile***
>>> 1 Save the data to a file.

>>> 0 Data display only.

>> ***Filename***
>>> Filename where the data will be saved.

>> ***AddDateAndTime***
>>> 1 The first column will store the date and time.

>>> 0 The first column will store the values of the first magnitude.

3. **parameters.json**

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
