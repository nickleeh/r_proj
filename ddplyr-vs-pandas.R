### http://pandas.pydata.org/pandas-docs/stable/comparison_with_r.html

### ddply
require(plyr)
df <- data.frame(
  x = runif(120, 1, 168),
  y = runif(120, 7, 334),
  z = runif(120, 1.7, 20.7),
  month = rep(c(5,6,7,8),30),
  week = sample(1:4, 120, TRUE)
)

head(df)

ddply(df, .(month, week), summarize,
      mean = round(mean(x), 2),
      sd = round(sd(x), 2))


### ----------------
### data.table
require(data.table)
dt <- setDT(df, key = c("month", "week"))
dt[, .(mean = round(mean(x), 2),
       sd = round(sd(x), 2)),
   by= .(month, week)]


### ----------------
### pandas
df = pd.DataFrame({
    'x': np.random.uniform(1., 168., 120),
    'y': np.random.uniform(7., 334., 120),
    'z': np.random.uniform(1.7, 20.7, 120),
    'month': [5,6,7,8]*30,
    'week': np.random.randint(1,4, 120)
})


grouped = df.groupby(['month','week'])

print grouped['x'].agg([np.mean, np.std])
                  mean        std
month week                       
5     1      71.840596  52.886392
      2      71.904794  55.786805
      3      89.845632  49.892367
6     1      97.730877  52.442172
      2      93.369836  47.178389
      3      96.592088  58.773744
7     1      59.255715  43.442336
      2      69.634012  28.607369
      3      84.510992  59.761096
8     1     104.787666  31.745437
      2      69.717872  53.747188
      3      79.892221  52.950459
