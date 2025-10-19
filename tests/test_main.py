"""Initial test module for the TNT project."""

from src import main


def test_main_prints_welcome(capsys) -> None:
    """The main entry point should greet the user."""
    main.main()
    captured = capsys.readouterr()
    assert "Welcome to the TNT project!" in captured.out
