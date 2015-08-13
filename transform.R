### To learn data transform in data.table using example from:
## http://stackoverflow.com/questions/21315997/python-pandas-vs-r-transformation-code-conciseness

# Raw data
data <- data.frame(
    metalname=c('Al','Cd','Cr','Co','Cu','Au','Fe','Pb','Mo','Ni','Pt','Au','Ta','Ti','W','Zn'),
    radius=c(0.1431,0.1490,0.1249,0.1253,0.1278,0.1442,0.1241,0.1750,0.1363,0.1246,0.1387,0.1445,0.1430,0.1445,0.1371,0.1332),
    crystal=c('FCC','HCP','BCC','HCP','FCC','FCC','BCC','FCC','BCC','FCC','FCC','FCC','BCC','HCP','BCC','HCP'))

data


## Calc lattice parameters (nm)
data_transformed <- rbind(
    transform(subset(data, crystal=='BCC'), N=2, latticea=4*radius/sqrt(3), latticec=0),
    transform(subset(data, crystal=='FCC'), N=4, latticea=2*radius*sqrt(2), latticec=0),
    transform(subset(data, crystal=='HCP'), N=6, latticea=2*radius, latticec=4*radius*sqrt(2/3))
)

data_transformed

### ----------------------
### using data.table:

library(data.table)

dt <- data.table(data, key="crystal")

data_transformed_dt <- rbind(dt["BCC", .(metalname, radius, crystal, N=2, latticea=4*radius/sqrt(3), latticec=0)],
                             dt['FCC', .(metalname, radius, crystal, N=4, latticea=2*radius*sqrt(2), latticec=0)],
                             dt['HCP', .(metalname, radius, crystal, N=6, latticea=2*radius, latticec=4*radius*sqrt(2/3))])

data_transformed_dt
