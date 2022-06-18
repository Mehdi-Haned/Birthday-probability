using CSV
using PlotlyJS

raw =  CSV.File("Julia/projects/birthday-data.csv")

function processs_data(R)
    data = fill(0.0, (12, 31))
    total = sum(R["f0_"])
    for (m, d, f) in R
        data[m, d] = f/total
    end
    data[2, 29] *= 4
    data[data .< 1e-5] .= NaN64
    return data[reverse(1:12), :]
end

data = processs_data(raw)
months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug",
"Sept", "Oct", "Nov", "Dec"]
reverse!(months)

plot(
    heatmap(z = (data), colorscale="Jet", reversescale=false, y = months,
    transpose = true,  x = (1:31))
)

