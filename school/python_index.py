""" Build index from directory listing

make_index.py </path/to/directory> [--header <header text>]
"""
import os
import argparse
import sys



EXCLUDED = ['index.html', '.DS_Store']


# May need to do "pip install mako"
from mako.template import Template


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("directory")
    parser.add_argument("--header")
    args = parser.parse_args()
    folder = [fname for fname in sorted(os.listdir(args.directory))
              if fname not in EXCLUDED and '.' not in fname]
    files =  [fname for fname in sorted(os.listdir(args.directory))
              if fname not in EXCLUDED and '.' in fname]
    header = (args.header if args.header else os.path.basename(args.directory))
    num_files = len(os.listdir(args.directory))
    spacing = str(4)
    structure = sys.argv[1].split("Website/")[1]
    iteration_of_resource = len(structure.split("/")) - 2
    resource_location = ""
    for i in range(0, iteration_of_resource):
    	resource_location = resource_location + "../"
    INDEX_TEMPLATE = r"""
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Business Casual - Start Bootstrap Theme</title>

  <!-- Bootstrap core CSS -->
  <link href=" """ + resource_location + """vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom fonts for this template -->
  <link href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href=" """ + resource_location + """css/business-casual.min.css" rel="stylesheet">
  <link href=" """ + resource_location + """vendor/fontawesome-free/css/all.min.css" rel="stylesheet">


</head>

<body>

  <h1 class="site-heading text-center text-white d-none d-lg-block">
    <span class="site-heading-upper text-primary mb-3">File Repository</span>
    <span class="site-heading-lower">Fall 2019 (UVA)</span>
  </h1>

  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark py-lg-4" id="mainNav">
    <div class="container">
      <a class="navbar-brand text-uppercase text-expanded font-weight-bold d-lg-none" href="#">Start Bootstrap</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav mx-auto">
          <li class="nav-item px-lg-4">
                <a class="nav-link text-uppercase text-expanded" href=" """ + resource_location + """index.html">Home
                    </a>
          </li>
          <li class="nav-item active px-lg-4">
            <a class="nav-link text-uppercase text-expanded" href=" """ + resource_location + """about.html">About</a>
          </li>
          <li class="nav-item px-lg-4">
            <a class="nav-link text-uppercase text-expanded" href=" """ + resource_location + """products.html">Products</a>
          </li>
          <li class="nav-item px-lg-4">
            <a class="nav-link text-uppercase text-expanded" href=" """ + resource_location + """store.html">Store</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <section class="page-section about-heading">
    <div class="container">
        <br>
      <div class="about-heading-content">
        <div class="row"> 
          <div class="col-xl-9 col-lg-10 mx-auto">
            <div class="bg-faded rounded p-5">
              <h2 class="section-heading mb-4">
                <span class="section-heading-upper">Index of</span>
                <span class="section-heading-lower">""" + structure + """</span>
              </h2>
              <p>Fall 2019 (Relevenat files)</p>
              <div class="row">
				% for name in names:
				    <div class="col-xl-""" + spacing + """"><a href="${name}"><i class="fas fa-folder-open">${name}</a></i></div>
				% endfor
				% for name in files:
				    <div class="col-xl-""" + spacing + """"><a href="${name}"><i class="fas fa-file">${name}</a></i></div>
				% endfor
				</div>
            </div>
          </div>

        </div>
      </div>
    </div>
  </section>

  <footer class="footer text-faded text-center py-5">
    <div class="container">
      <p class="m-0 small">Copyright &copy; Your Website 2019</p>
    </div>
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>

"""
    print(Template(INDEX_TEMPLATE).render(names=folder, files=files,header=header))


if __name__ == '__main__':
    main()
