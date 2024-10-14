# Extract a subset of the dataset
extract_subset <- function(file_path, b = 1, N, subset_file) {
  head_lines <- readr::read_lines(file_path, skip = 0, n_max = b)
  remaining_lines <- readr::read_lines(file_path, skip = b + 1)
  sample_lines <- sample(remaining_lines, N)
  write_lines(c(head_lines, sample_lines), subset_file)
}

# usage example
# extract_subset(input_file, 1, 100, output_file)
