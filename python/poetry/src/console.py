import click

from . import __version__

@click.command()
@click.version_option(version=__version__)
def main():
    """src Python project."""
    click.echo("..src..")
    click.echo(__version__)
