using Statistics

export calcRSquared, leastSquaresRegression

function calcRSquared(actual::Vector{Float64}, estimated::Vector{Float64})::Float64
	@assert length(actual) == length(estimated)
	ssr = sum((actual - estimated) .^ 2);
	actualMean = mean(actual);
	sst = sum((actual .- actualMean) .^ 2);
	return 1. - ssr / sst
end

function leastSquaresRegression(x::Vector{Float64}, y::Vector{Float64})::Tuple{Float64, Float64, Float64}
	@assert length(x) == length(y)

	x̄ = mean(x);
	ȳ = mean(y);
	m = cov(x, y) / cov(x);
	b = ȳ - m * x̄;

	ŷ = x * m .+ b;
	R² = calcRSquared(y, ŷ);

	return (m, b, R²)
end
