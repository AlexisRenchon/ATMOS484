"""
    main()

Generates and write a DataFrame containing ATMOS484 flux tower, met, soil and respiration data
"""
function main()
  df1 = fluxtowerdata(); println("getting flux tower data...")
  df2 = metdata(); println("getting met data...")
  df3 = soildata(); println("getting soil moisture and temperature data...")
  df4 = respdata(); println("getting respiration data...")
  Dtime = collect(Dates.DateTime(DateTime(2019, 11, 23, 00, 00, 00)):Dates.Minute(30):now())
  df = DataFrame(datetime = Dtime)
  df = leftjoin(df, df1, on = :datetime); println("merging timesteps...")
  df = leftjoin(df, df2, on = :datetime, makeunique = true)
  df = leftjoin(df, df3, on = :datetime)
  df = leftjoin(df, df4, on = :datetime)
  sort!(df, :datetime)
  CSV.write(joinpath("output","ATMOS484.csv"), df); println("writing .csv file in output/ATMOS484.csv")
  return df
end
