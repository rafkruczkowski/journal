from matplotlib import pyplot as plt

years = [1950, 1960, 1970, 1980, 1990, 2000, 2010]
gdp = [300.2, 543.3, 1075.9, 2862.5, 6979.6, 10289.7, 14958.3]

# create chart
plt.plot(years, gdp, color='green', marker='o', linestyle='solid')

# add title
plt.title("Nominal GDP")

# add a lable to y-axis
plt.ylabel("Billions of $")
#plt.show()
plt.savefig('ex1.png')
