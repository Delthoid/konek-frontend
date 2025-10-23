import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konek_frontend/config/sizing_config.dart';
import 'package:konek_frontend/core/widgets/inputs/custom_field_button.dart';
import 'package:konek_frontend/core/widgets/widgets.dart'
    show LabeledTextAreaField, LabeledTextFormField;
import 'package:konek_frontend/features/servers/domain/models/server_create_request.dart';
import 'package:konek_frontend/features/servers/presentation/bloc/servers_bloc.dart';

class ServerCreateForm extends StatefulWidget {
  const ServerCreateForm({super.key});

  @override
  State<ServerCreateForm> createState() => _ServerCreateFormState();
}

class _ServerCreateFormState extends State<ServerCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _nameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _nameFocusNode.requestFocus();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServersBloc, ServersState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            spacing: SizingConfig.spacingMedium,
            mainAxisSize: MainAxisSize.min,
            children: [
              Focus(
                focusNode: _nameFocusNode,
                autofocus: true,
                child: LabeledTextFormField(
                  label: 'Server Name',
                  controller: _nameController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Server name is required'
                      : value.length < 4 || value.length == 100
                      ? 'Server name must be between 4 and 100 characters'
                      : null,
                ),
              ),
              LabeledTextAreaField(
                label: 'Description',
                controller: _descriptionController,
              ),
              SizedBox(
                width: double.infinity,
                child: CustomFieldButton(
                  text: 'Create',
                  isLoading: state is ServerCreateInProgress,
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      BlocProvider.of<ServersBloc>(context).add(
                        ServerCreated(
                          ServerCreateRequest(
                            name: _nameController.text,
                            description: _descriptionController.text,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
