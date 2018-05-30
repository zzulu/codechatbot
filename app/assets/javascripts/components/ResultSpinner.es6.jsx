class ResultSpinner extends React.Component {
  constructor(props) {
    super(props)
    this.startSpin = this.startSpin.bind(this);
    this.state = {
      frames: ['⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'],
      index: 0
    }
  }

  componentDidMount() {
    this.interval = setInterval(this.startSpin, 80);
  }

  componentWillUnmount() {
    clearInterval(this.interval);
  }

  startSpin() {
    nextIndex = this.state.index + 1;
    if(nextIndex >= this.state.frames.length) { nextIndex = 0; }
    this.setState({ index: nextIndex })
  }

  render() {
    return(
      <pre>{this.state.frames[this.state.index]}</pre>
    );
  }
}
