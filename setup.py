import pathlib
from setuptools import setup, find_packages

here = pathlib.Path(__file__).parent
README = (here / "README.md").read_text()

VERSION = '0.1.0'


setup(
    name="chapar",
    version=VERSION,
    description="A custom made wrapper for message broker",
    long_description=README,
    long_description_content_type="text/markdown",
    author="Sed Medy",
    author_email="sed.medy@gmail.com",
    license="MIT",
    classifiers=[
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.7",
    ],
    packages=["chapar"],
    include_package_data=True,
    install_requires=[],
    entry_points={
        "console_scripts": [
            "realpython=chapar.__main__:main",
        ]
    },
)