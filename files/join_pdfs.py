import PyPDF2
import os

def merge_pdfs(output_filename, input_filenames):
    pdf_merger = PyPDF2.PdfMerger()

    for pdf_file in input_filenames:
        pdf_merger.append(pdf_file)

    with open(output_filename, "wb") as output_file:
        pdf_merger.write(output_file)

# Example usage:
pdf_files = sorted([file for file in os.listdir() if ".pdf" in file])

output_pdf = "merged_output.pdf"  # Output PDF file name
merge_pdfs(output_pdf, pdf_files)

