abstract class FormEnvioStatus {
  const FormEnvioStatus();
}

class InitialFormStatus extends FormEnvioStatus {
  const InitialFormStatus();
}

class FormEnviando extends FormEnvioStatus {}

class EnvioSuccess extends FormEnvioStatus {}

class EnvioFailed extends FormEnvioStatus {
  final Exception? exception;

  EnvioFailed({this.exception});
}
