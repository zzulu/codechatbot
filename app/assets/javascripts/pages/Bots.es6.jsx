class Bots extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      bots: this.props.bots
    }
  }

  deleteBot(e) {
    
  }

  render () {
    return (
      <div className="container">
        { this.props.bots.map(
            (bot) => (
              <Bot key={bot.id} bot={bot} />
            )
          )
        }
      </div>
    );
  }
}

Bots.propTypes = {
  bots: PropTypes.array
};

